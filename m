Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7466383DD6
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 21:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhEQTyl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 15:54:41 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:38781
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235435AbhEQTyk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 15:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621281203; bh=oMie1qSAn9OMNvaE91ujwbveUvoIVEMsAAvOw4vhaUw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=J4S9t/uUgt5Ejl5udY6trgL7Q4SS0fnUNiKIfft0AXboJoWCyQGXCEBXvvqZoD0oAakeYNnj2TQkurAPmAkkzZG/jfrSQ0i6yrE6i+kYwsl1cuKbJt8FFdFLU01hzqOqRhTlElKFTN3PljyCW9tViC1EdWu4AbRZUFZ36yn7REkcrGUFZtrsTqY88lVRMfPXA77a0MLZEHHIQW6fe10iqHr7u/eG1MowD10xaMQQiWimNqEcKmUD3MK32Zf5lxGnIMZac0+uN90Yf0P6L4GfrxkX/rLD8dULRhW+7MumiSgi3385lYuHB+mexfvlwO7AqLQ/DbQkNNN3BhI3LeCiRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621281203; bh=Z1N4seJDzpV8WKoJD+BQlg2BUbRI5WgIg2O7VF8+nvY=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=s1WTNuvmRc0vXTRO3YXWIxiLYjA9QaLkjf6OGX0ctp2AqGBTKF+ENURqKEetDtctHiCNB3L3YbMXtDvzRLAfDeiDJrGZQSynmLfzvFCjViK+99ukBCEEZ3ca98WpZC/zcRkjeICoP38tvSnai7jt7fI4sCu3ooLGKkYWjY6Gt1ieqoRmKEJr+I0Jy5qph/xOy2HrT/VrEoQDjfRnv/ShHU0geRKuhvpcbezbixek686M9A006SWH6WwNA7ENLuL1Kyjp6g20S0w4Dec1VncNiP1zJA+yp1b/K5+alXaR1cOxwqzBAhRWxCtM+ro9EsfSgJKd/U4NWRtJ98hxgA4znQ==
X-YMail-OSG: clz78JUVM1mZaxt1XvgH.yBMKKK2rt_bTkXjcCDrN4peIL7tTgAMLA9_LxQvoiq
 JxV5fbQbOG..bNDmqu3s_oJ_zaofnYWsyFzrNVOfFNT6FUHasKOeEu_F.Xp.DLH5mHwflY84jxtr
 PS_sFhwXZ6k5A3l_RcqY2LzQ8qxoAi9mEeLadNdT0_lDNyVLaMrQVSGVf_OAhN2yU.UaJNWLxKbz
 _UD.ATocKscxT_XMY0homy90RK8owvizGhJedG1imuXxAwYEpsbjaLJ5vstxG16rAUWBI4iSpi8C
 TSp3Yh2gQneveumuPLogAx_lbOntWxpNF_JWHrY1QXlcQRboTgTc8d7Rf1ZzpPW7AVNGSThZJhvS
 tpBPYBua.LwNBQBFYrwgA66uMRSDZTfeixb5z7EDO7zd9sSgmoIVtUVk3hCNRj8MEqcX65uSxj19
 r.k5zn2nn186Yog4GI.EmFkRK0tT_c38YxorvHdJqIsRcDW5YGuADtryJFMYNzdpiTnDXfQsDAtH
 IoUj4oDHOlaGTc_Rx0cprnDyiua2vQ6QBwlom2pzTcgR.gNw1_WIfLJ9AgK0ybuvvEy42k9CLLk7
 eokUNOzFVTUIOifKTB5GI.OPRDNyQWeHMEqcH7l9zWdJxNWFg5TdnxBTU2bV4ay_Nli6znWsk3xN
 1OgaFSi2v908pw6v6Mfu4bHUfZ3zCF7jgmcGNAike4iIkWHzjUOR9RCAZyPuaBSfm2po9ipaghtS
 uOf8e5R8c8UMAehPiURymx6gEYPVu5Wa49JCjt.9zhQ0h3Y1fpfdwgOsagrFIkSYbQ2gl.gayjLZ
 WSM9goeC7MIQgK9iX.4yoTrADpCKVSyuEiZce0JCN_K3a0CMxKBn6xGVdDsJ5FWzIw.Xfvl0Sl.U
 t6i048T5ycQz.4Ldk0iCIrogPp7V.yNcf94R7btk2IUsXIZJ37wZFM0GY4WBlbAkSKrDdCpuB7Vw
 F4W.LNfkD_0Jc8Jyxiy1bGMF.AY7_Ilz_PBKcbEbTjzfMlMyekr46eW4ccy9QO.ImqnWK8vbnCHx
 wDjrBtofXBWLuZZbEnB6HP0i_eKuuaRj9mnwuR7.VV3uHe32VG4Az0T3uzLfK3aluXpHGH3vebXL
 aByiB7u0gcgqjAwBcJE1t_NfKn.kHnvdjkGnKH75WXCxyOM.zU75rVa5vIHLshM3h9Uxo4siGIrN
 uYS_hukiHBnJhOocRgGHeqKax6Jdo2uTvecXC_mzSeh1qafkSIQyHYAlXo9ynAYshBLIoQmXoVou
 6NC7tasJAypBOykSd6_UfaKrVG.JGT9YB.B7FCw1GRzWJ9YF4SumjNOrAtKsrtVwwuuOLLGFjiVU
 EyZamjJEtTSX6yjVy_NJspYX3nXgHNju78P0FCjQQ0A0799dYpHo1QpulfiSW5hmA5pygDn6FLKp
 W0ImxfPJy.vFqTClVOgvA9HoLwYQVHlKL4.N0JMs2j_4TxOCuXn7PFCX_3P.rRCqBQmMk0j_eh_j
 g9uZb037eys5wK4qzdCkeRd5S0GhSFTdFGGco2EBYfCuRF8Xx5sgXgOvidkFkXoZW8sG0oc5Ao98
 0m6xq.QBf71LQ4omgr.ekjfbntpj4k94UHbuAn5aMU0HeAB1ZvBGLA3SxiVH_ZXaq_XCVgSn5Eiz
 AXtgaHmWufFb4hVY4guvfgKhKSJEmrVIvz_eF6HCwC00WyvOkb0x4YiIJjb8Zg.BYjsHY9nMxehr
 LotGJkMTPubsqFh9AO04D5cowEUtYMu5xDLZ.1X26Dhyc8Y6ETXsnlVOSaPhD3ZBnPMfwxdxptl7
 wxd2RltJPuLTH6Q0pNgpAcBoNBYrZ_zHrMDmXoex.tIDoamxLUeDpvPXDgel1m0BdLCJF6EQaZCM
 8_Ku9lLBQB06eDQbJctnAsoAEylVuGIHSNOERw5lKdHXe_N88SqgnoF5PKp3uHcA_omIAzol87kO
 h8I3bzPJtVXJG9gMFFOiVIbRXU540AmLk4cvZUa7zuVxhT7.AY5e3AIyiJgPWTRJ3BxLdzvgFIei
 OY5dJAMgB_yeyu47f47fbRQBbAotMcmBDWptwhBRuNdbKdVDIIygB6ZboOKvIbvZJ1gkOfEnisBI
 xnmat6hbm_LLoh_aGWarfia.9R5ZBenE5f4xReHAM.22p3bYjK_A7y.WQYEkYTN_S5LfZ5lRJDVM
 j3yZqAJIZO2FpFYrTUaR8J61G6z6MqU.5Hq0mHWwA.dmWVhxstDTJNGvpFVDvVEQpxN.u81CVxWb
 s4YgUoX3amamywG6JoLUj8CPvwy3jOKxwd5fdyaEq0lhAFiF95XHY4qBNXB_2qHU614vCifXBaLl
 O.ZAA_Bc0H0eae1RxegtmtPd_ngHjcq5FWvHVWn4raaGyLdtuxAwt1yBOuHmJdg9wg_syUh0.kUY
 HcpOIzd3rzwmwg0_dcOasMLNgcfK0cRBzXUynQ64pAlUo7aDWV3ki6_OklUmWSUL0VFcFxlaFaro
 ljhtadAxoVHufzKb0R.kJKscKUgoX1Lm2QwWp.paC1qog1.w5WVF2vthWEU16McXMtdXAKaNzjw1
 yKLtxt700FCf4p_NleqpIJB1o3_l2dJxr4PoEKAxm2tQYG8Np.3a0GiJgV4lfYQn.CuzgYFz_6Zj
 8C2LgYth_XZkzWG3PsMmodXoHW3bVo.xkJJ_NS7GRqZ.tGFgIrLvZx9hpo2pC13qPG3iDe9_ml4M
 9ANmMoZBacrCrEVsBBw6kCq._ALbRdYvQwI6l8dk4VDlscqUJZtIC0leW.MHRBvlheigZVPxExFk
 mgt1X6eaK8yOauC4NSF99oKFJ6ZXnDy81hCU7Em3KmerfLFsJMxLhjhHLcWtJ3.xKsRsz58YRch9
 _WUZXtGVD19jJmaYCurm5BhVaNNxexJkqSG1p1nlBsdjOWf9dnkx7ftoZq2uN1SVS1iDPhYIfYSw
 zeaxTdFWiNaT4EYCi.dXfkjHJ9ABOhhbujNaZOuTe48uA4ph4Iinyyk.pUi8eTTxsPrEL5nBzyp_
 pckWBUyeOqHdBW63V80oUcyrbwY36SnQr7ocQpXPw2Nkn3mqFiPSFAFASDcKLq6trevphA0in6AJ
 rKplusIT5RusrdGClCc7dzlMSqViSZq8AVPWhHTbH94D26_PykibJob7OQjfH8TC3OOJ15yKiFHS
 S4NwdvvcSaS72q9uqViyMKaoTQln_9U1LjTpECZWVUTqZvyO0jvxB4gFBrnpXO_kA8l05Dbkyx9z
 bRsjoDaSt7sHRz_dwOuop_0dhDNe2cdpS.oPvtwLjUFiiNQyVnoEBF4rANYmHX4zyG0bt1vcz7tX
 pbpWW5zMbyF_Q_A3P6crIiksjrh.TA1iZi7bw5ArPOkBO2vGf896SiD.0_aLCSEp9JAUekvP.LcF
 VkYe4qq8.JlUsvx9Od6NEUewsBFqHtfUljdlnz5JlR6.vPMMHLMV5XXyF6_aPnOaH.ME5SzQlU2g
 XxOBIsvUCwpdhknYuEiFmUanmOispJV5LL7kLKdhoBEEgn.rD695aNoU.iVvfJ0SeoU.rNSnL95T
 uXDLnzP2w9PQR_trZji1vtEnOOoEr3Q7hXIEHN3G8LwIz57KxL6fzhsHbbk.bxYzjzWKwk9EC5YL
 TL5eFxd8aPQjHdkmeR_77eBGv4w0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 May 2021 19:53:23 +0000
Received: by kubenode588.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 87d9bbaed3e67aac6a58bc34694023d9;
          Mon, 17 May 2021 19:53:19 +0000 (UTC)
Subject: Re: [PATCH v26 14/25] LSM: Specify which LSM to display
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-15-casey@schaufler-ca.com>
 <202105141218.21BDA22F@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c1ab101a-7ee3-6d20-c8b1-cff5bcdfe98c@schaufler-ca.com>
Date:   Mon, 17 May 2021 12:52:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202105141218.21BDA22F@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18291 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/14/2021 12:23 PM, Kees Cook wrote:
> On Thu, May 13, 2021 at 01:07:56PM -0700, Casey Schaufler wrote:
>> Create a new entry "interface_lsm" in the procfs attr directory for
>> controlling which LSM security information is displayed for a
>> process. A process can only read or write its own display value.
>>
>> The name of an active LSM that supplies hooks for
>> human readable data may be written to "interface_lsm" to set the
>> value. The name of the LSM currently in use can be read from
>> "interface_lsm". At this point there can only be one LSM capable
>> of display active. A helper function lsm_task_ilsm() is
>> provided to get the interface lsm slot for a task_struct.
>>
>> Setting the "interface_lsm" requires that all security modules using
>> setprocattr hooks allow the action. Each security module is
>> responsible for defining its policy.
>>
>> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
>> SELinux hook provided by Stephen Smalley <stephen.smalley.work@gmail.c=
om>
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-api@vger.kernel.org
>> Cc: linux-doc@vger.kernel.org
>> ---
>>  .../ABI/testing/procfs-attr-lsm_display       |  22 +++
>>  Documentation/security/lsm.rst                |  14 ++
>>  fs/proc/base.c                                |   1 +
>>  include/linux/lsm_hooks.h                     |  17 ++
>>  security/apparmor/include/apparmor.h          |   3 +-
>>  security/apparmor/lsm.c                       |  32 ++++
>>  security/security.c                           | 166 ++++++++++++++++-=
-
>>  security/selinux/hooks.c                      |  11 ++
>>  security/selinux/include/classmap.h           |   2 +-
>>  security/smack/smack_lsm.c                    |   7 +
>>  10 files changed, 256 insertions(+), 19 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display
>>
>> diff --git a/Documentation/ABI/testing/procfs-attr-lsm_display b/Docum=
entation/ABI/testing/procfs-attr-lsm_display
>> new file mode 100644
>> index 000000000000..0f60005c235c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/procfs-attr-lsm_display
>> @@ -0,0 +1,22 @@
>> +What:		/proc/*/attr/lsm_display
>> +Contact:	linux-security-module@vger.kernel.org,
>> +Description:	The name of the Linux security module (LSM) that will
>> +		provide information in the /proc/*/attr/current,
>> +		/proc/*/attr/prev and /proc/*/attr/exec interfaces.
>> +		The details of permissions required to read from
>> +		this interface are dependent on the LSMs active on the
>> +		system.
>> +		A process cannot write to this interface unless it
>> +		refers to itself.
>> +		The other details of permissions required to write to
>> +		this interface are dependent on the LSMs active on the
>> +		system.
>> +		The format of the data used by this interface is a
>> +		text string identifying the name of an LSM. The values
>> +		accepted are:
>> +			selinux		- the SELinux LSM
>> +			smack		- the Smack LSM
>> +			apparmor	- The AppArmor LSM
>> +		By convention the LSM names are lower case and do not
>> +		contain special characters.
>> +Users:		LSM user-space
>> diff --git a/Documentation/security/lsm.rst b/Documentation/security/l=
sm.rst
>> index 6a2a2e973080..b77b4a540391 100644
>> --- a/Documentation/security/lsm.rst
>> +++ b/Documentation/security/lsm.rst
>> @@ -129,3 +129,17 @@ to identify it as the first security module to be=
 registered.
>>  The capabilities security module does not use the general security
>>  blobs, unlike other modules. The reasons are historical and are
>>  based on overhead, complexity and performance concerns.
>> +
>> +LSM External Interfaces
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>> +
>> +The LSM infrastructure does not generally provide external interfaces=
=2E
>> +The individual security modules provide what external interfaces they=

>> +require.
>> +
>> +The file ``/sys/kernel/security/lsm`` provides a comma
>> +separated list of the active security modules.
>> +
>> +The file ``/proc/pid/attr/interface_lsm`` contains the name of the se=
curity
>> +module for which the ``/proc/pid/attr/current`` interface will
>> +apply. This interface can be written to.
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 3851bfcdba56..10de522f3112 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2807,6 +2807,7 @@ static const struct pid_entry attr_dir_stuff[] =3D=
 {
>>  	ATTR(NULL, "fscreate",		0666),
>>  	ATTR(NULL, "keycreate",		0666),
>>  	ATTR(NULL, "sockcreate",	0666),
>> +	ATTR(NULL, "interface_lsm",	0666),
> Anyone can open this file... (continued below)
>
>>  #ifdef CONFIG_SECURITY_SMACK
>>  	DIR("smack",			0555,
>>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index c61a16f0a5bc..d2c4bc94d47f 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1686,4 +1686,21 @@ static inline void security_delete_hooks(struct=
 security_hook_list *hooks,
>> =20
>>  extern int lsm_inode_alloc(struct inode *inode);
>> =20
>> +/**
>> + * lsm_task_ilsm - the "interface_lsm" for this task
>> + * @task: The task to report on
>> + *
>> + * Returns the task's interface LSM slot.
>> + */
>> +static inline int lsm_task_ilsm(struct task_struct *task)
>> +{
>> +#ifdef CONFIG_SECURITY
>> +	int *ilsm =3D task->security;
>> +
>> +	if (ilsm)
>> +		return *ilsm;
>> +#endif
>> +	return LSMBLOB_INVALID;
>> +}
>> +
>>  #endif /* ! __LINUX_LSM_HOOKS_H */
>> diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/=
include/apparmor.h
>> index 1fbabdb565a8..b1622fcb4394 100644
>> --- a/security/apparmor/include/apparmor.h
>> +++ b/security/apparmor/include/apparmor.h
>> @@ -28,8 +28,9 @@
>>  #define AA_CLASS_SIGNAL		10
>>  #define AA_CLASS_NET		14
>>  #define AA_CLASS_LABEL		16
>> +#define AA_CLASS_DISPLAY_LSM	17
>> =20
>> -#define AA_CLASS_LAST		AA_CLASS_LABEL
>> +#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
>> =20
>>  /* Control parameters settable through module/boot flags */
>>  extern enum audit_mode aa_g_audit;
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 392e25940d1f..4237536106aa 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -621,6 +621,25 @@ static int apparmor_getprocattr(struct task_struc=
t *task, char *name,
>>  	return error;
>>  }
>> =20
>> +
>> +static int profile_interface_lsm(struct aa_profile *profile,
>> +				 struct common_audit_data *sa)
>> +{
>> +	struct aa_perms perms =3D { };
>> +	unsigned int state;
>> +
>> +	state =3D PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
>> +	if (state) {
>> +		aa_compute_perms(profile->policy.dfa, state, &perms);
>> +		aa_apply_modes_to_perms(profile, &perms);
>> +		aad(sa)->label =3D &profile->label;
>> +
>> +		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int apparmor_setprocattr(const char *name, void *value,
>>  				size_t size)
>>  {
>> @@ -632,6 +651,19 @@ static int apparmor_setprocattr(const char *name,=
 void *value,
>>  	if (size =3D=3D 0)
>>  		return -EINVAL;
>> =20
>> +	/* LSM infrastructure does actual setting of interface_lsm if allowe=
d */
>> +	if (!strcmp(name, "interface_lsm")) {
>> +		struct aa_profile *profile;
>> +		struct aa_label *label;
>> +
>> +		aad(&sa)->info =3D "set interface lsm";
>> +		label =3D begin_current_label_crit_section();
>> +		error =3D fn_for_each_confined(label, profile,
>> +					profile_interface_lsm(profile, &sa));
>> +		end_current_label_crit_section(label);
>> +		return error;
>> +	}
>> +
>>  	/* AppArmor requires that the buffer must be null terminated atm */
>>  	if (args[size - 1] !=3D '\0') {
>>  		/* null terminate */
>> diff --git a/security/security.c b/security/security.c
>> index f5407a85641e..1ce125c01782 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -77,7 +77,16 @@ static struct kmem_cache *lsm_file_cache;
>>  static struct kmem_cache *lsm_inode_cache;
>> =20
>>  char *lsm_names;
>> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
>> +
>> +/*
>> + * The task blob includes the "interface_lsm" slot used for
>> + * chosing which module presents contexts.
>> + * Using a long to avoid potential alignment issues with
>> + * module assigned task blobs.
>> + */
>> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init =3D {
>> +	.lbs_task =3D sizeof(long),
>> +};
>> =20
>>  /* Boot-time LSM user choice */
>>  static __initdata const char *chosen_lsm_order;
>> @@ -669,6 +678,8 @@ int lsm_inode_alloc(struct inode *inode)
>>   */
>>  static int lsm_task_alloc(struct task_struct *task)
>>  {
>> +	int *ilsm;
>> +
>>  	if (blob_sizes.lbs_task =3D=3D 0) {
>>  		task->security =3D NULL;
>>  		return 0;
>> @@ -677,6 +688,15 @@ static int lsm_task_alloc(struct task_struct *tas=
k)
>>  	task->security =3D kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>>  	if (task->security =3D=3D NULL)
>>  		return -ENOMEM;
>> +
>> +	/*
>> +	 * The start of the task blob contains the "interface" LSM slot numb=
er.
>> +	 * Start with it set to the invalid slot number, indicating that the=

>> +	 * default first registered LSM be displayed.
>> +	 */
>> +	ilsm =3D task->security;
>> +	*ilsm =3D LSMBLOB_INVALID;
>> +
>>  	return 0;
>>  }
>> =20
>> @@ -1732,14 +1752,26 @@ int security_file_open(struct file *file)
>> =20
>>  int security_task_alloc(struct task_struct *task, unsigned long clone=
_flags)
>>  {
>> +	int *oilsm =3D current->security;
>> +	int *nilsm;
>>  	int rc =3D lsm_task_alloc(task);
>> =20
>> -	if (rc)
>> +	if (unlikely(rc))
>>  		return rc;
>> +
>>  	rc =3D call_int_hook(task_alloc, 0, task, clone_flags);
>> -	if (unlikely(rc))
>> +	if (unlikely(rc)) {
>>  		security_task_free(task);
>> -	return rc;
>> +		return rc;
>> +	}
>> +
>> +	if (oilsm) {
>> +		nilsm =3D task->security;
>> +		if (nilsm)
>> +			*nilsm =3D *oilsm;
>> +	}
>> +
>> +	return 0;
>>  }
>> =20
>>  void security_task_free(struct task_struct *task)
>> @@ -2171,23 +2203,110 @@ int security_getprocattr(struct task_struct *=
p, const char *lsm, char *name,
>>  				char **value)
>>  {
>>  	struct security_hook_list *hp;
>> +	int ilsm =3D lsm_task_ilsm(current);
>> +	int slot =3D 0;
>> +
>> +	if (!strcmp(name, "interface_lsm")) {
>> +		/*
>> +		 * lsm_slot will be 0 if there are no displaying modules.
>> +		 */
>> +		if (lsm_slot =3D=3D 0)
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * Only allow getting the current process' interface_lsm.
>> +		 * There are too few reasons to get another process'
>> +		 * interface_lsm and too many LSM policy issues.
>> +		 */
>> +		if (current !=3D p)
>> +			return -EINVAL;
> ... but context isn't established by just checking "current", as this
> file handle may have been given to another process.
>
> I suspect the security_get/setprocattr needs to gain a pointer to "file=
"
> so that the f_cred struct can be examined[1] (i.e. compare opener
> against reader/writer).
>
> [1] https://www.kernel.org/doc/html/latest/security/credentials.html#op=
en-file-credentials

It's not credentials being checked here. The check is whether the task th=
at
would be affected is "current". Process A can't open /proc/B/attr/interfa=
ce_lsm
with write access. The only process that can open it for write access is =
B.
If process B opens /proc/B/attr/interface_lsm for write access it could s=
end
the file handle to process A, but process A can't write to the file becau=
se
(current !=3D p) that is, (A !=3D B).

>> +
>> +		ilsm =3D lsm_task_ilsm(p);
>> +		if (ilsm !=3D LSMBLOB_INVALID)
>> +			slot =3D ilsm;
>> +		*value =3D kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
>> +		if (*value)
>> +			return strlen(*value);
>> +		return -ENOMEM;
>> +	}
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>  		if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> +		if (lsm =3D=3D NULL && ilsm !=3D LSMBLOB_INVALID &&
>> +		    ilsm !=3D hp->lsmid->slot)
>> +			continue;
>>  		return hp->hook.getprocattr(p, name, value);
>>  	}
>>  	return LSM_RET_DEFAULT(getprocattr);
>>  }
>> =20
>> +/**
>> + * security_setprocattr - Set process attributes via /proc
>> + * @lsm: name of module involved, or NULL
>> + * @name: name of the attribute
>> + * @value: value to set the attribute to
>> + * @size: size of the value
>> + *
>> + * Set the process attribute for the specified security module
>> + * to the specified value. Note that this can only be used to set
>> + * the process attributes for the current, or "self" process.
>> + * The /proc code has already done this check.
>> + *
>> + * Returns 0 on success, an appropriate code otherwise.
>> + */
>>  int security_setprocattr(const char *lsm, const char *name, void *val=
ue,
>>  			 size_t size)
>>  {
>>  	struct security_hook_list *hp;
>> +	char *termed;
>> +	char *copy;
>> +	int *ilsm =3D current->security;
>> +	int rc =3D -EINVAL;
>> +	int slot =3D 0;
>> +
>> +	if (!strcmp(name, "interface_lsm")) {
>> +		/*
>> +		 * Change the "interface_lsm" value only if all the security
>> +		 * modules that support setting a procattr allow it.
>> +		 * It is assumed that all such security modules will be
>> +		 * cooperative.
>> +		 */
>> +		if (size =3D=3D 0)
>> +			return -EINVAL;
>> +
>> +		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
>> +				     list) {
>> +			rc =3D hp->hook.setprocattr(name, value, size);
>> +			if (rc < 0)
>> +				return rc;
>> +		}
> Similarly here -- how do the LSMs reason about who actually _opened_
> this file?
>
> -Kees
>
>> +
>> +		rc =3D -EINVAL;
>> +
>> +		copy =3D kmemdup_nul(value, size, GFP_KERNEL);
>> +		if (copy =3D=3D NULL)
>> +			return -ENOMEM;
>> +
>> +		termed =3D strsep(&copy, " \n");
>> +
>> +		for (slot =3D 0; slot < lsm_slot; slot++)
>> +			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
>> +				*ilsm =3D lsm_slotlist[slot]->slot;
>> +				rc =3D size;
>> +				break;
>> +			}
>> +
>> +		kfree(termed);
>> +		return rc;
>> +	}
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>  		if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>> +		if (lsm =3D=3D NULL && *ilsm !=3D LSMBLOB_INVALID &&
>> +		    *ilsm !=3D hp->lsmid->slot)
>> +			continue;
>>  		return hp->hook.setprocattr(name, value, size);
>>  	}
>>  	return LSM_RET_DEFAULT(setprocattr);
>> @@ -2207,15 +2326,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u3=
2 *seclen)
>>  {
>>  	struct security_hook_list *hp;
>> -	int rc;
>> +	int ilsm =3D lsm_task_ilsm(current);
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)=
 {
>>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D lsm_slot))
>>  			continue;
>> -		rc =3D hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
>> -					      secdata, seclen);
>> -		if (rc !=3D LSM_RET_DEFAULT(secid_to_secctx))
>> -			return rc;
>> +		if (ilsm =3D=3D LSMBLOB_INVALID || ilsm =3D=3D hp->lsmid->slot)
>> +			return hp->hook.secid_to_secctx(
>> +					blob->secid[hp->lsmid->slot],
>> +					secdata, seclen);
>>  	}
>> =20
>>  	return LSM_RET_DEFAULT(secid_to_secctx);
>> @@ -2226,16 +2345,15 @@ int security_secctx_to_secid(const char *secda=
ta, u32 seclen,
>>  			     struct lsmblob *blob)
>>  {
>>  	struct security_hook_list *hp;
>> -	int rc;
>> +	int ilsm =3D lsm_task_ilsm(current);
>> =20
>>  	lsmblob_init(blob, 0);
>>  	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)=
 {
>>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D lsm_slot))
>>  			continue;
>> -		rc =3D hp->hook.secctx_to_secid(secdata, seclen,
>> -					      &blob->secid[hp->lsmid->slot]);
>> -		if (rc !=3D 0)
>> -			return rc;
>> +		if (ilsm =3D=3D LSMBLOB_INVALID || ilsm =3D=3D hp->lsmid->slot)
>> +			return hp->hook.secctx_to_secid(secdata, seclen,
>> +						&blob->secid[hp->lsmid->slot]);
>>  	}
>>  	return 0;
>>  }
>> @@ -2243,7 +2361,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>> =20
>>  void security_release_secctx(char *secdata, u32 seclen)
>>  {
>> -	call_void_hook(release_secctx, secdata, seclen);
>> +	struct security_hook_list *hp;
>> +	int ilsm =3D lsm_task_ilsm(current);
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
>> +		if (ilsm =3D=3D LSMBLOB_INVALID || ilsm =3D=3D hp->lsmid->slot) {
>> +			hp->hook.release_secctx(secdata, seclen);
>> +			return;
>> +		}
>>  }
>>  EXPORT_SYMBOL(security_release_secctx);
>> =20
>> @@ -2384,8 +2509,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, char __use=
r *optval,
>>  				      int __user *optlen, unsigned len)
>>  {
>> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> -				optval, optlen, len);
>> +	int ilsm =3D lsm_task_ilsm(current);
>> +	struct security_hook_list *hp;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stre=
am,
>> +			     list)
>> +		if (ilsm =3D=3D LSMBLOB_INVALID || ilsm =3D=3D hp->lsmid->slot)
>> +			return hp->hook.socket_getpeersec_stream(sock, optval,
>> +								 optlen, len);
>> +	return -ENOPROTOOPT;
>>  }
>> =20
>>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_b=
uff *skb,
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 0133b142e938..dba867721336 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6510,6 +6510,17 @@ static int selinux_setprocattr(const char *name=
, void *value, size_t size)
>>  	/*
>>  	 * Basic control over ability to set these attributes at all.
>>  	 */
>> +
>> +	/*
>> +	 * For setting interface_lsm, we only perform a permission check;
>> +	 * the actual update to the interface_lsm value is handled by the
>> +	 * LSM framework.
>> +	 */
>> +	if (!strcmp(name, "interface_lsm"))
>> +		return avc_has_perm(&selinux_state,
>> +				    mysid, mysid, SECCLASS_PROCESS2,
>> +				    PROCESS2__SETDISPLAY, NULL);
>> +
>>  	if (!strcmp(name, "exec"))
>>  		error =3D avc_has_perm(&selinux_state,
>>  				     mysid, mysid, SECCLASS_PROCESS,
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/in=
clude/classmap.h
>> index 62d19bccf3de..8f4b0dd6dd78 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -53,7 +53,7 @@ struct security_class_mapping secclass_map[] =3D {
>>  	    "execmem", "execstack", "execheap", "setkeycreate",
>>  	    "setsockcreate", "getrlimit", NULL } },
>>  	{ "process2",
>> -	  { "nnp_transition", "nosuid_transition", NULL } },
>> +	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>>  	{ "system",
>>  	  { "ipc_info", "syslog_read", "syslog_mod",
>>  	    "syslog_console", "module_request", "module_load", NULL } },
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 5c10ad27be37..7aa7ea38f627 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3508,6 +3508,13 @@ static int smack_setprocattr(const char *name, =
void *value, size_t size)
>>  	struct smack_known_list_elem *sklep;
>>  	int rc;
>> =20
>> +	/*
>> +	 * Allow the /proc/.../attr/current and SO_PEERSEC "interface_lsm"
>> +	 * to be reset at will.
>> +	 */
>> +	if (strcmp(name, "interface_lsm") =3D=3D 0)
>> +		return 0;
>> +
>>  	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel=
))
>>  		return -EPERM;
>> =20
>> --=20
>> 2.29.2
>>

