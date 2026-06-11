package leadwerks.support;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.ExprTools;

typedef FieldProperty =
{
	var name:String;
	var type:haxe.macro.Type;
	var doc:String;
};

class EntityScriptBuilder
{
	public static final globalSelfRef:String = "_G._hxwerks_self_";

	public static function build():Array<haxe.macro.Field>
	{
		var newFields:Array<haxe.macro.Field> = [];
		var additionalStartStatements:Array<Expr> = [];
		var startMethod:haxe.macro.Field = null;

		for (field in Context.getBuildFields())
		{
			if (field.access.contains(APublic) && !field.access.contains(AStatic))
			{
				Context.fatalError("entity script classes may not have non-static public fields", field.pos);
			}

			switch (field.kind)
			{
				case FVar(t, e) if (!field.access.contains(AStatic)):
					var propertyMeta = fieldGetMeta(field, "property");
					var isLwProperty = propertyMeta != null;
					var isReadOnly = (fieldGetMeta(field, "readonly") != null) || field.access.contains(AFinal);

					if (field.access.contains(APublic))
					{
						Context.fatalError("public entity script fields are not allowed", field.pos);
					}
					if (field.access.contains(AInline))
					{
						Context.fatalError("inline entity script fields are not allowed", field.pos);
					}
					if (!isLwProperty && isReadOnly)
					{
						Context.fatalError("only @property fields may be readonly", field.pos);
					}

					var meta:haxe.macro.Metadata = [];
					if (isLwProperty)
					{
						if (e == null && propertyMeta.params.length == 0)
						{
							Context.fatalError("@property fields need a default initializer (e.g. var x:Int = 0)", field.pos);
						}
						var propParams:Array<Expr> = if (propertyMeta.params.length > 0 && e != null)
						{
							propertyMeta.params.concat([e]);
						} else if (e != null)
						{
							[e];
						} else
						{
							propertyMeta.params;
						};
						meta.push({name: "property", pos: field.pos, params: propParams});
					} else if (e != null)
					{
						additionalStartStatements.push({expr: EBinop(OpAssign, macro $i{field.name}, e), pos: field.pos});
					}

					var luaPropRef = '${globalSelfRef}.${field.name}';
					newFields.push(
						{
							name: field.name,
							pos: field.pos,
							meta: meta,
							access: [APrivate],
							doc: field.doc,
							kind: FProp("get", isReadOnly ? "never" : "set", t)
						});

					newFields.push(
						{
							name: 'get_${field.name}',
							pos: field.pos,
							meta: [
								{name: ":noCompletion", pos: field.pos}, {name: ":pure", pos: field.pos}],
							access: [APrivate, AInline],
							kind: FFun(
								{
									args: [],
									ret: t,
									expr: macro return untyped $i{luaPropRef}
								})
						});

					if (!isReadOnly)
					{
						newFields.push(
							{
								name: 'set_${field.name}',
								pos: field.pos,
								meta: [
									{name: ":noCompletion", pos: field.pos}],
								access: [APrivate, AInline],
								kind: FFun(
									{
										args: [
											{name: "value", type: t}],
										ret: t,
										expr: macro return untyped $i{luaPropRef} = value
									})
							});
					}

				case FProp("default", _, _, _) | FProp(_, "default", _, _) if (!field.access.contains(AStatic)):
					Context.fatalError("entity script fields with default access are not supported", field.pos);

				case FFun(f) if (field.access.contains(ADynamic) && !field.access.contains(AStatic)):
					Context.fatalError("entity script shall not define non-static dynamic functions", field.pos);

				case FFun(f) if (field.name == "start"):
					startMethod = field;

				default:
					newFields.push(field);
			}
		}

		if (additionalStartStatements.length > 0)
		{
			if (startMethod == null)
			{
				startMethod =
					{
						name: "start",
						pos: Context.currentPos(),
						access: [AOverride],
						kind: FFun(
							{
								args: [],
								expr: macro
								{
									super.start();
									$b{additionalStartStatements};
								}
							})
					};
			} else
			{
				switch (startMethod.kind)
				{
					case FFun(f):
						startMethod =
							{
								name: startMethod.name,
								meta: startMethod.meta,
								pos: startMethod.pos,
								access: startMethod.access,
								doc: startMethod.doc,
								kind: FFun(
									{
										args: f.args,
										expr: macro
										{
											super.start();
											$b{additionalStartStatements.concat([f.expr])};
										}
									})
							};
					default:
						Context.fatalError("start is not a function?", startMethod.pos);
				}
			}
		}
		if (startMethod != null)
		{
			newFields.push(startMethod);
		}

		return newFields;
	}

	static function fieldGetMeta(field:haxe.macro.Field, name:String):haxe.macro.MetadataEntry
	{
		for (m in field.meta)
		{
			if (m.name == name)
				return m;
		}
		return null;
	}
}
#end
