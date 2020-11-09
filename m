Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522912AC87F
	for <lists+linux-api@lfdr.de>; Mon,  9 Nov 2020 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgKIW3B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Nov 2020 17:29:01 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:41124
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729585AbgKIW3B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Nov 2020 17:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604960939; bh=o6a/Uk3cYSRwkGFnLw6+RYNM1r332z+HpY84UvgWzpM=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=aPvbYfKrl90C4hOJQJYuJS8JRWdHxeCAJYlmuO32qN2s/gWfzK0lpkA0F70vjl5looIHT+fhkpHyedTfih6D3CszHejGhIUTPOnDt+F92aI3n3THF41IVV5K4Pfkm9fzWdPsQLLYbdfhf4uOiyyqQVbhHjLKz34lyyI7hlT8VRJHQepIeff2BOLWFcwyRYM07e3LBYY+chHPGQ5K7nJC4wKYa1goOU9t+73RgHZ9yawaWpJTo+3ltP8xXqbyfALEJJ66Pyf7Xz6/ZkHFtn6jnF4zgzAMjl8pYnZFiJ4JBDm7C1cc/nDWYRCEDxhrSMfaYv3vZJEJFeC9lnKlSQzgVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604960939; bh=ZnRAVgmgLxl39IUBafpZOoQ1pU8pJIz7KzIl/gbbWjO=; h=To:From:Subject:Date:From:Subject; b=ucJn03Dlr9YQUHpYiraSsjhpkvB0bbHkFJ5DuJc/x/VqAAQpCxIZ3SDQm2rvQVnqQtIts04XKfyNBQ7kfTxN6EEyE7NOu79S+7lTKtjC773JKxlsmJlfcJhf9ZD6hbfmYFJZNHQLLL2hbqPYe0ZE2JyqIae/tAm/p9qjQ901m9CO5/ZE6eMd+5DDlEt5OChJ30tjZJPq/d86pirNTzR4E0kU4b0Gd5G7D6NKIehX9aC4FrE/qjFirYo4qxhZ16XYNhRI3EoNBOp2h0roStU2Z6fK8sO9VZK8DoVPBq/zvAZ5UBD2d0IQw2cDHIOV7UhqhycomE8PmEinC+BEZF9rnQ==
X-YMail-OSG: xiQBN6kVM1me6g_w2Q3h2C.PyMxp8FtbcKlrvJ3mkoIDRp3gFtSOpZrKJJ0V5NV
 1a..Ldqt0OWXNtR3GVwRVoJCySk4c9aMhIEO4WK8pSLO2AvOifAcOJFZzWKWO4JXOirueDfN_nXU
 Akpl.3RSEcNeqXJZBcXfYp6mO2bgfkJcwoCVPxT6IN6VmRBYhdXvqMyGI7gD24saVq88fjHuUbAh
 Vd6KMa7BGu4hMne6TlDx87Nm2zrylkNQXBQmaf5H2tUWq2yCBSFbbmK8dyS_h_1MucCJpKDFyBpl
 NoZtuN0AX.SRO7jPhtOpQ0XApbHkelMcfqWAgIG9pGFjBCbdBmwTY6f_yy9Y5IUWwzxyzW3esOWu
 O2V6N6g5nqHmiuNYvEfz1HR2rKTwE9NX_6MU_NdMSOjQHT9YyfjqBaOFNl6PyI1A.pxfWkPmmJ5L
 Mni_2RM2xBiC0PVT_.9GN9GRbmaZrbFnbGUVOT2rp3vRJ6Hstffj3kPrm3Q.hl9GQxpPDqeg_hBY
 ge3PLzejkzAhlNtFMt0AjfORm9Iw41f_38PSou3HfNRQYzTJkHO7dCG2xKOG7OOKFqC_S_OloOwo
 iaxFpCUnNLOhb.KY.xBdOnVQN7ySpej7240xpQgSZGoMPHSf36EZtLXY6PaOl8gQfj.bhuJKfSUa
 .8IPw6AXd6dEwX4bPl.DPFxXVH2l9nAVjmgMRG581B3OPnaToSflslHYT.FfrA__aRZORbZDW.OC
 KlhAKmOQvRwilpa4SoIJF._ax32UW0qRmqf0cp48uL2znW.Ix.NqLQIPzNhhC.xg7FW_X2R75Hn5
 _TBFtC5dJuYZaM3vdWREjzs0Ijo20YepG6m1RpRUIlq35E9ZKgxSFG7dgA6oLSaq3jg48gCsLSB5
 goej5exII0TZdcGxjF0Sy3CdJtqfC8EemC2f.Ba5Ug3OC4qFqsE.ZdtfZ7da45SM2hGTgBBRVZxN
 ImpMn8RCEoRkq5FwhbXzzOeZzG.Vu6nmb7LVLv2LXz5xEXnY0N_dC.iHwLolbylncYWVKS5dBq4u
 oIrCNnOYaY3wnjUYQZTVgHM42sujjjmmLAra2v5KNjN0GpZK_SyycLGyLfHF3FSWc8P3kTd_Tm3V
 1UIogPrj63CCZUr0kP8lpmOa4_0NWK_F.JMKoUPKOc9.jzwiFfYwaJ_obSrJxEOrdqySIvUs3UD6
 aTMkzRoFbS.3IDvYCYYhMcuZ2C1mJGJoyMyr_2PeI_gdbLhip3OyIU7xbAGX0EE9TQQVaGWIb.2k
 W_x2wkapW0sBkl8RvLRzn7MA9qC23h2hfdkIolR6FOBHYlCNmsVKB_52fYXSUXonKFFW.yy7kAal
 THtz9lrIcjgtip0E5gupIT13pDKV7Zty_1CQ2Y.bALjs18OQh2bOQu.hc_JE7u3kBFzal0N9waMa
 D8c0Z7S3dME2yiXLUTCi7isdPXO8nbeZRq7JsVLpJoerJWzdDIttlowG7ZcVi7xVXU7mWWzDSUAq
 HswRoQLOo_uolCp3lKllw8ThJDDm7iec3qamwNtJspx0N7ltsSbnQM3PsgOeG4f6P5gg._hVqDh4
 Xa9QQnUQIy7uKvG_pSLGOv1Hxv5.ExwZwxLesyC0q2ka4fCtz4ZmWJQFUWhZDUZtiGIuB1DMFU1X
 _vA_uTdFkFCQ2ToojD51E0xnQ1Ux.Mo13ihHrCygPM6T5c94TMoNw4V0aIgTFiONl4WVf7qviD75
 sNtauX7Td6LLDUyBjo0qPGTtgZIpzqSqQfcslUyL4eMB2G.0SqRCABjM.cZpfn8E90gTgYGDKRXe
 zhQ_Ureu5XcDGRERKTpc.f8Ifrv8DEue4u5av1MKwXXfEtez..Jmqyg7HK8675uPME_.CTQ55hJ_
 f._230Es1_4XC1R59G46DQ.s4POVdwOJqth9LxGZnDH30Ff7DPqDLcjgls4LqH.9e63xtmKrKon9
 jpwy4DH3S9NY140mppQUNKjXSk1YgLiekz5GXyiQHtXbPBJBti2gFmi9AGF7B_e7BtZZzU.Dx9DK
 rkDg0P4VPsvGI3ypD9_F5A9SgUXd32TyufKs6BiQ5Wu33ACCCQjcanmxzZ.pHmd5eJonsAGbjkMW
 tHv8lYNfIA9UO6zsEs5vwBGV9fQd73YMd6CP7hnxEzZvX8E.ZFvvjA6.lcp04BGbJLZGHM5n_Udy
 i.u6f.vHAEpJENU1_Mwfd4fCGjmaAUOurYYtqH6QxTxnaQTV20xzi6IaqDGApAXEi3XLA1pP3cnM
 kp9qTo8XAu.eBHPFKg_e9DCIYRX5uXuUD9GLIrZXvRiF0x5bhXZXY4Ss7cyrvtYvYgHQn5p2xz9V
 lVCuC0BFCdOewySKHxzJ4eaXvZsvH2xWPRgQCkF8luDrb9mTmyKTtUg.8RuXLH59ZvMs4sNRgTdi
 ThhxCxcw8dP8yH9O2C6yWWsrkJMabujKaaa_1wfj0EKBsf0bFfSGaq8mJz_ZOwczk9gHW.obJdrj
 lgolYkjI2w9wvHTwVO92qsLc6i1a174czL9yX41xaAJTBFKZSNqm0s7AOzNqtEfCDJTw7PbaG91q
 IYB0unTF233KEGnuhEN.hCSc8gHzrqAphBKedtZL_Wcmb1K1KzEoFuuKe4w2jyJBwY6kXji3KHnp
 Mx1AVapoGiPFGNwzCKCrFNEVhxQZa2m4AZ1SnskH7BCfztAVu5EgvYCdrH0332bQgRwy7Pl3C.Et
 E8zl1Pn6rsePTJN9bNZlosDfrPMi7PteBOtaLaa04EdSmKdLpD4IpF2uO87aDPeAg1sNiw5xFnBc
 a1ol4Go5XsLuLQ7f5bzHvWhxCgsEXFLwfIbvSrrrXxyCrNaqoZxFn2C06mrOfusHOBeoA2M6Zj8g
 2PFiy5rod7oc32nV.hKyqb0LA_yn8FhdFagk7T84MqJRrp0Z.qtOYlVDG6cQW_rHIqJUYk7Fwfbm
 7d3BLX_M0KZfYyHBa1AVE505crEieSCW39A6DrmsqpiurbcFMe.FD3ju6DfbQMSnne_MVMp2LpTF
 4IFwrroahHNtzOnQ8k31MRd8sZkEUKgq8bFgZFb38kJHBKssTctHiCFa2w6bOn3AZpj7f71B7B57
 qiwfG6Xkn2v0Ft6EjE_WmHVcsAizJWPu3EPvHX3bmm0WXWsDPSE62yVabAdwI8Gk1royokIQrreo
 1hXKwCXZZmZ6CbGFua1k_htc_XrtYQF4aNuPIq.DKxPXNwGiQB30e5Hmvj9TZ25WIeIYhA4HsSNF
 SgLgoL64hBxDSMaszPKilVNpMLRIlfJV4RJ2WCxlh1LGHNapzg2gTsbRd1jiJy13EY5wD74sq6vE
 3GbXIfFGrCcHs8fMC0gKE.vLcc0usnN8FFC_jOZA2g_DNl9d8HK9QORZsWgNX8fFalylClbUkrFO
 p9xxQzQ2AQ_2T3ViZaNLy_DIHVe3mj3_zrDWe8OpBEBD7.uqDoeEHr_ww0FtuqiouArkgVWdCfiB
 njyolNkevoCb0N4zlNhHV_ChA2x_SV9yekq8Rl1dr8iMaa.yIyloQVlIN6uNGRhsP4ZHLJ6W6_YE
 xdA1XbqoG858cYUsaAYWHOCoiw6g5rpzOih5Qv58IN_hMfWw51B13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Nov 2020 22:28:59 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 20ea086e6e6c90586ab3a5e58b3b53f7;
          Mon, 09 Nov 2020 22:28:53 +0000 (UTC)
To:     John Johansen <john.johansen@canonical.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
 <20201104234114.11346-13-casey@schaufler-ca.com>
 <20201105092245.GB3439341@kroah.com>
 <31027d8e-50bc-70be-b4f2-a96a84de2bae@schaufler-ca.com>
 <20201107091529.GA23328@kroah.com>
 <04b4adf9-9313-7f5a-e7fe-6132e0c5fc4f@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v22 12/23] LSM: Specify which LSM to display
Message-ID: <496cad0c-9bca-24e9-6024-76a8b73754ed@schaufler-ca.com>
Date:   Mon, 9 Nov 2020 14:28:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <04b4adf9-9313-7f5a-e7fe-6132e0c5fc4f@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/7/2020 2:05 PM, John Johansen wrote:
> On 11/7/20 1:15 AM, Greg KH wrote:
>> On Fri, Nov 06, 2020 at 04:20:43PM -0800, Casey Schaufler wrote:
>>> On 11/5/2020 1:22 AM, Greg KH wrote:
>>>> On Wed, Nov 04, 2020 at 03:41:03PM -0800, Casey Schaufler wrote:
>>>>> Create a new entry "display" in the procfs attr directory for
>>>>> controlling which LSM security information is displayed for a
>>>>> process. A process can only read or write its own display value.
>>>>>
>>>>> The name of an active LSM that supplies hooks for
>>>>> human readable data may be written to "display" to set the
>>>>> value. The name of the LSM currently in use can be read from
>>>>> "display". At this point there can only be one LSM capable
>>>>> of display active. A helper function lsm_task_display() is
>>>>> provided to get the display slot for a task_struct.
>>>>>
>>>>> Setting the "display" requires that all security modules using
>>>>> setprocattr hooks allow the action. Each security module is
>>>>> responsible for defining its policy.
>>>>>
>>>>> AppArmor hook provided by John Johansen <john.johansen@canonical.co=
m>
>>>>> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
>>>>>
>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>> Cc: linux-api@vger.kernel.org
>>>>> ---
>>>>>  fs/proc/base.c                       |   1 +
>>>>>  include/linux/lsm_hooks.h            |  17 +++
>>>>>  security/apparmor/include/apparmor.h |   3 +-
>>>>>  security/apparmor/lsm.c              |  32 +++++
>>>>>  security/security.c                  | 169 +++++++++++++++++++++++=
+---
>>>>>  security/selinux/hooks.c             |  11 ++
>>>>>  security/selinux/include/classmap.h  |   2 +-
>>>>>  security/smack/smack_lsm.c           |   7 ++
>>>>>  8 files changed, 223 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>>>> index 0f707003dda5..7432f24f0132 100644
>>>>> --- a/fs/proc/base.c
>>>>> +++ b/fs/proc/base.c
>>>>> @@ -2806,6 +2806,7 @@ static const struct pid_entry attr_dir_stuff[=
] =3D {
>>>>>  	ATTR(NULL, "fscreate",		0666),
>>>>>  	ATTR(NULL, "keycreate",		0666),
>>>>>  	ATTR(NULL, "sockcreate",	0666),
>>>>> +	ATTR(NULL, "display",		0666),
>>>> That's a vague name, any chance it can be more descriptive?
>>> Sure. How about lsm_display, or display_lsm? I wouldn't say that
>>> any of the files in /proc/*/attr have especially descriptive names,
>>> but that's hardly an excuse.
>> I still don't understand what "display" means in this context.  Perhap=
s
> its the LSM thats context is being displayed on the shared interface,
> ie. /proc/*/attr/*
>
> thinking about it more owner or even interface_owner might be a better
> name

I was hoping for a single word, but I see how something more descriptive
might be in order. How about "lsm_of_current"? Or "lsm_of_dot_slash_curre=
nt",
if you want to be pedantic. "format_of_current" isn't quite accurate, but=

might be easier for some people to understand. Maybe "interface_owning_ls=
m".

/proc/*/attr/display answers the question "Which LSM is providing the dat=
a
I see if I look in /proc/*/attr/current, prev or exec or if that process =
uses
SO_PEERSEC".


>> documentation will help clear it up?
>>
> yeah this needs documented.

Agreed. I've noticed that nothing in /proc/*/attr seems documented
in an orderly (documentation/ABI) fashion. I will have to fix some of
that for a description of /proc/*/attr/whatever_it_ends_up_getting_called=

to make sense. Working on it.

>> thanks,
>>
>> greg k-h
>>

