
//The character file as base for both player and enemy

class AAngelCharacterBase : ACharacter
{
        // Explicit root component
   // UPROPERTY(DefaultComponent, RootComponent)
    //USceneComponent SceneRoot;
    
    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Weapon", DisplayName = "Weapon Mesh", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    UStaticMeshComponent WeaponMeshComponent;
    // Set default values for subobjects with `default` statements
    // No need and no function of CreatedefaultSubObject
    
    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Weapon", DisplayName = "Projectile Weapon Mesh", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    USkeletalMeshComponent ProjectileWeaponMeshComponent;

    UPROPERTY(DefaultComponent,VisibleAnywhere,BlueprintReadWrite)
    UPawnNoiseEmitterComponent PawnNoiseEmitterComp;

    UFUNCTION(BlueprintCallable, Category = AI)
    void ReportNoise(USoundBase SoundToPlay, float Volume)
    {
        if(SoundToPlay != nullptr)
        {
            Gameplay::PlaySoundAtLocation(SoundToPlay,GetActorLocation(),GetActorRotation(),Volume);
            MakeNoise(Volume,this,GetActorLocation());
        }
    }


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