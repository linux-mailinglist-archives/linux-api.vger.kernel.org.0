Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB42AA1C1
	for <lists+linux-api@lfdr.de>; Sat,  7 Nov 2020 01:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKGAUv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Nov 2020 19:20:51 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:41280
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgKGAUt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Nov 2020 19:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604708448; bh=gkd8sZ9xzVrD+FlaEZYuY9mwC0xoyx+zLvO2l5DnFXI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ug4bFiDwVJO9iT7xD/HlO36K9DUaeb1rqP6nilp14u3kYCJB9g6QW3CHyHDpLl4a9+6JY/hBMLZng4ihTyNb876YatQFYoValSK8FhEM7AzN8ut2n92+HR1Z04kKASatHk4002SGD1gllVKkDC31kSIMx19PaDD1/5YBQBVeKcMd8t5szckJ6vyzdPrNP2fjgmE/H7GBTnhx2jf4jJhJ11WBIlcsDR8f7Q9oY/K/3qMuWwRNcOGPHoLi0V451z0O8nhTXPj94nszWCQiBP0baslnq1715mDBAVTGcR2hZ0BqFrkcrKudiOsMg7iIhhMR2RJAL10gZ2njyRTtoVLktw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604708448; bh=Q3eO4F0+6Df77idtdx7He1NCEibMmDaZoV4ndY6Nnty=; h=Subject:To:From:Date; b=ZSijOY3H+LIWKBtRCDqXQ3eTgYjkES83hBaeYbvE7kSoEjPiSDPx2iittGVGGTYoJHPXsVzrVjoIqo1JkCI8C4q/qz69i8RyFhKpzZk/lAKoQtzCTbHZIbKvyYcEPwj4BRSzQ1dxvUnhvfxY15A0qFsYgQPEKG6PuAHqFcjKLbzeSpOykOM2nQP6Mm24mtxIA8Zfu9lU9cUrwSQlOkxKwZ98jqlk2IBIPyz6G3CTahF09FJKQes8kBu0IfhhAMxDACTAuythUrzs69L2sLBL6zPFVUqQH5JPCBYDNHa16OWIqr+hrI8uQQfDArSruSQHuPR2qONW3QgXH2Lwz3wArg==
X-YMail-OSG: KhRms4kVM1l.WnJPcrMQ6zb0vrLwRIxCOsI7MFZ_a1KP.jp8QWGCy7Laj5HIwPv
 TQx3K2MPBNoDKcyb3vLqQFLFPDZ_A30YM3H1kW_r9wluG12nY.Tls6pn6zfP18p2yePhkYjX7jUh
 bKMwm91vrgQjJCk05igB7AB6sJs8c2Lmu8ddg_Q5OPHB2Cw7g3BXx6X86n7wBssHxCObf3Bg39Qm
 rAxd4eaMmtYZpXm2EMurR2RgJ4ZBIMj5g0Sfm5J342244GV.8Hwrn2WTWvELp44hal14WefJMdhF
 yFY6b4HwkeU5yGfeKTHalcQrJ_UxKgutHQXfwJyYZrYURtcDLB0fT5pXnYErLMycX6Ufmb4lKePl
 DzSk2cOheveQkfVEU7i6TSRY9pYr1AAf4Ia0cA5ckSaUR650zKfYK_Cn4k_jva6TEs.xFEj457Ta
 G3Ijzf043DtP9Pr_hxVTbUgQox3nlbQBNQLc6Em6vrzMtkeoP7uDE0V5K4vvfrcRKz3E.zUEWwEZ
 givbpyLjQjXHXiLEGxPxqG0AFHtB5X_ym4XJYWp8Xczxox2FG3jp2KRfPHzVSfMuDNxalGPlj5KB
 Hw4W2G6nH9vQlka0W0fHRFhsJIg3DTOiZ2NuOOtVQASf1VCx0U986tlxFAHAKBXyd_HMjP6uB652
 7vdFIYIj39hfqxmjw_KiYfKwEV2YrVK5Abv5AshaUp_a9cGsUVsmkd6AzhCHw54.P.oms4hqPImf
 H.NiXBjgvFlyJn_r9nKBGAPIEp4XqPYzvyc2eDVdbxUheWg7xNyNweCFNDlsLv_qzsm5joAJrvcI
 uLkPxSz_afGEAXk2fqJG6c4CXHUxiOvnrDqjtGtJKmlvViuKnV3oNKytGA.pW.MEWIc5bzWLfqru
 hJxqo6Tk3bXrVy8056Pyi0N37y1dWEL65HcHJqtsgE1uEt04nb7JEZV15GulFsUpJarU37M46RKe
 tw0FUKAfWJEABKVEZytDG9YRZ.L2FIXQynqSxM3HL9jbtGauwjIHiE1EiRI5MAc_RK464qqhOuKQ
 ii_1euYYzrWcbuFO77ZNBSZEo9Zzf7YaYLv5Z1sfWU3fM.FqBMk1FCake1VhIbZ5RCABoTX2I_7Q
 aFPvGemEFXd8gxmWeJmPHV84cpClpBb36aLK5uWCI5hPbS4Tv0.wXSPDxJkFQrlhGE5YCOE0yLdk
 ZvVWaNGLR7FSt7hhMgrhrXbmn_YYOQVzy0_drEdn9Jeuz4sX2SXZaSSrSKygkwE1OWzaA4RL9XfM
 HGJ1M8xBdjcZTgsi5fW3AoTMu9v0WJtlGvcHWJWDshhZG6.JVthQ0gfhe9F3WbOfR9JAxHnlP.68
 G_ZSlunrTkSZAaTZ7vZTW8A15X.xG9W8fTpQkOIHFHQBPqxr6n_pt7XaNLLR0Dr81NNY8hrDRMcj
 z0JSl00rhGmaUiCzk.OE44jzHPaXg31o144f6KhfKWQ0sNkZq1U6Y1rE8eAUjN8h7ykm83USuJr_
 xPBaxZ70VwS_5iScjiQOBM2p2W3IrSV3F1HFHeTLEAIXPXmJGU34xybkwagaRjX6ghXxnCYrUVHS
 dnHqkc2b5iOvxkfm0bNMeP1VuVqO16yWDdVJEqcR1tn2bCLqC6fMI5UO1LCwUycRo24xo2eHjHNM
 N0j5n8kNHIdTZQJogZVdA5MXjuVqM_eaTl6jiv55lEkm6jzzpqWyuTm3ztijoGvTYPAjSfbRRCpp
 TL2MJf1tkS_rTFCmI4zIAGHlTtGvxRfyVe08W9lap7YOonyCFEd_r5BFrTp4pC3seEUrdtCsHcSj
 50KoLa_ik9WOYEwee3SaxDKJKBqy3SWBoizJVAwFBE422bBV.zR8.X5UrL6zK9cbVN5idTzLHCoq
 FG26Llj5O_DdLdZ.tk7UbwIqHGr3MllU8ZOkl0rZcAP1p0if8tRb_EC4qikdoklBGbITEmnmvm3A
 mba82c7LKksXc8uFPuFpOumNor0f8woMC1vdQ_OcBnc9WBvlNHN208hyBbuJpiZ81hJWxxEwsnnE
 h2p0C5I8ZRnUQrc7VEumlW0QkDBufupAITn4Vs5OGrHO73afBxKNQle2Z9MIQ2JNiV9SaiRnWVPz
 .7Xn7bVHmdsosUR0Wxy5RrscXA_381QktmdLq572OFGqRIc4JrNQiRnWLK3IVG3mi.zam.NCHnAZ
 pmtAEAXN61GdrfZSSnn2eMDqDnJNh1L87njeQgAdn8B347EFDivjXdFkfFCKRwMmdWj.GR637S5K
 RZLA3kxqnkn9Wv1B26i_ZsEkft68f1F6Vok6u4vFb6shW0G6S7z_43H6qi6WK5oDpvfb8BtJOtFx
 7iSGDINxhxKexts63gcbntib0pqkLfpw5uUFDGKON38hMs.iSTUNmShY_AD6xSNoaYtclWvaMoUx
 bNVM7nGjZ5w15MKr_RUzpuf3HgEqn6Nhsn1YddVAMtJyfR9nRdT8t1nlSKmb3cPCZOX5ZbhqQuNl
 LxlTdnu7SY5LsxfZ1rOuoOBEv40EC9vXkFjEVgamLmspTzY9dn4zjZUG9b5bQBiIVy4v2VRwhotP
 j5PZswuOOrbDo0WbKDqkNQes1V2293Nmp61SinbbvQAz7.CXasuL5_L9Ark1TEhFRjeB5w3zzgn.
 lOavbh84rID7PkYkofQ5F_iJOm3TDslGQSZTrG437dSTNXfKOVKvLQdPVkeaJFJUjMsOmeCRMTG5
 7QG.mmHNyBeXmAAGCg1okvrd6VlSwPBIm9DLeFQ_eo.G3vkpnXXKhNLHaZ864EqeDFMRZFZlwOy6
 TWppgmqlvtXQkTzDemHBU4bhReEFgki8E_c3zClF7c4ykLkBiPsvnX__Kwa3Kquvhpvy1_nicEhZ
 q0uNrgcUBqaYLKPNrQDasZutKVmEmktL1zsexGMgwzRHlCWyS_.__6SBvVuH5hMNFJoOdxeKC61a
 2uQ.AUHR399MZMN9c53m9vXEoDbF8AdJOtSMf0qdNFLaX_YsB8R04HlpUvsEkGbxe3a9kdB_8EJd
 h8SSMuQ6A3gVzM0.EOtW02J6Hh6XgMR85kOxwNQUEcqa6M2eI1f7PdVEuzvks2Aq9K5ocsZmzkdu
 jLDThHV_jKJqDPwSnU2bmyJ8rzgSgh.go1JS_ML3puATlrV36Y.3hjNjfFN696YfPU5WtG_yZdNg
 mEhkhkYIlmxfLaSahRefzy.G2UTaF1m.L5_dOWWpUutkkLUudoKXNgD_2JhQLxqccpo10oN6R0HJ
 592f2iDdl3.DZkWMmTo.b7tiUhROOKyf.vuHg2j7vv_3.DkqQi.yWevrUZZuNoQoJKbxsW5sZclW
 XV1En6wsAGJERrWkOVvyMGQ._h2Xbo.sWzaTk0fuuzR7LGvWK23yz54Qy2lDmt1Z72e2mzmNm.qw
 SuGMR27lhfSx3iu0nb4XaB.sBQgTg_0JhRajt5ZJJfmoxZBuSM3pMLc_eQB4TigcOANX9BdKQHj5
 zzefCZgqP0Zc.nB4RhMsU855cJxCJUP6gFICrW6wfLkYRUmCL3M.bxCHkllChKL0hw9nzXm2kPV.
 EOdyNu0NEN6uIOVaw2k6.Mb2xgVag4BwawyQwwcSXgnQRb7tnobLtdu5G1ePb1.b2zya9ur7i2rq
 90AegAJ1tessa7g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Nov 2020 00:20:48 +0000
Received: by smtp412.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a2775549ebdce05967a3db044c741a58;
          Sat, 07 Nov 2020 00:20:44 +0000 (UTC)
Subject: Re: [PATCH v22 12/23] LSM: Specify which LSM to display
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
 <20201104234114.11346-13-casey@schaufler-ca.com>
 <20201105092245.GB3439341@kroah.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <31027d8e-50bc-70be-b4f2-a96a84de2bae@schaufler-ca.com>
Date:   Fri, 6 Nov 2020 16:20:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105092245.GB3439341@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/5/2020 1:22 AM, Greg KH wrote:
> On Wed, Nov 04, 2020 at 03:41:03PM -0800, Casey Schaufler wrote:
>> Create a new entry "display" in the procfs attr directory for
>> controlling which LSM security information is displayed for a
>> process. A process can only read or write its own display value.
>>
>> The name of an active LSM that supplies hooks for
>> human readable data may be written to "display" to set the
>> value. The name of the LSM currently in use can be read from
>> "display". At this point there can only be one LSM capable
>> of display active. A helper function lsm_task_display() is
>> provided to get the display slot for a task_struct.
>>
>> Setting the "display" requires that all security modules using
>> setprocattr hooks allow the action. Each security module is
>> responsible for defining its policy.
>>
>> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
>> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-api@vger.kernel.org
>> ---
>>  fs/proc/base.c                       |   1 +
>>  include/linux/lsm_hooks.h            |  17 +++
>>  security/apparmor/include/apparmor.h |   3 +-
>>  security/apparmor/lsm.c              |  32 +++++
>>  security/security.c                  | 169 ++++++++++++++++++++++++---
>>  security/selinux/hooks.c             |  11 ++
>>  security/selinux/include/classmap.h  |   2 +-
>>  security/smack/smack_lsm.c           |   7 ++
>>  8 files changed, 223 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 0f707003dda5..7432f24f0132 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -2806,6 +2806,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>>  	ATTR(NULL, "fscreate",		0666),
>>  	ATTR(NULL, "keycreate",		0666),
>>  	ATTR(NULL, "sockcreate",	0666),
>> +	ATTR(NULL, "display",		0666),
> That's a vague name, any chance it can be more descriptive?

Sure. How about lsm_display, or display_lsm? I wouldn't say that
any of the files in /proc/*/attr have especially descriptive names,
but that's hardly an excuse.

> And where is the Documentation/ABI/ entries for all of this, how does
> userspace know what these things are, and how to use them?

I'll add ABI descriptions and move some of the lsm.rst up from where it
is later in the patchset.

>
> thanks,
>
> greg k-h
