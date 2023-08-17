
//The character file as base for both player and enemy

class AAngelCharacterBase : ACharacter
{
    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Weapon", DisplayName = "Weapon Mesh", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    UStaticMeshComponent WeaponMeshComponent;
    // Set default values for subobjects with `default` statements
    // No need and no function of CreatedefaultSubObject
    
    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Weapon", DisplayName = "Projectile Weapon Mesh", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    USkeletalMeshComponent ProjectileWeaponMeshComponent;

    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        WeaponMeshComponent.SetCollisionEnabled(ECollisionEnabled::NoCollision);
        ProjectileWeaponMeshComponent.SetCollisionEnabled(ECollisionEnabled::NoCollision);

    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        
    }





}