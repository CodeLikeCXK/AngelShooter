
//The character file as base for both player and enemy

class AAngelCharacterBase : ACharacter
{
    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Weapon", DisplayName = "Weapon Mesh")
    USkeletalMeshComponent WeaponMeshComponent;
    // Set default values for subobjects with `default` statements
    // No need and no function of CreatedefaultSubObject
    
    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        WeaponMeshComponent.SetCollisionEnabled(ECollisionEnabled::NoCollision);
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        
    }





}