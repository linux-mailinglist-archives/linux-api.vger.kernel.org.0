Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A012B71F4CD
	for <lists+linux-api@lfdr.de>; Thu,  1 Jun 2023 23:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjFAVec (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jun 2023 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjFAVea (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jun 2023 17:34:30 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E5195
        for <linux-api@vger.kernel.org>; Thu,  1 Jun 2023 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685655269; bh=NCgW5WU/XNyE8jHskROTgS41hw62lYPlgQA2V+j//1w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=A27aN1er6zJABpPg0KewCIX2Nc8+HcP18uwXWMoOploQJU1owmZRDnjuDmH0bmm3lnnDJ2f9NtTJrd/jHtzkXkGmnF2HJJKS2/6VSDw7zWkz3GxtwyYHbOnJA0sHk8VEgr4eOw/U9W6XtQr0dUz8PQ4q+PLSXFSMMJS7QYOP0bBjnThVHugG+LkDqt8uty3trizCpF/82Dlt+hIUmzLQglZsjshNlIooQOY2Mp0CpO2hxx1g41U6+PY+2HPaDl/JXtCryI0SWF79XtTrdolUo8PyP3PF0RwFRMWctf4K4rm6Q11t5WUEoep84jaWq6gGhJFgm+Tw8QSaMg6vIQTc1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685655269; bh=oTm+/HpZRBYiOS/oLnRZ7rCCcVMq139XZZ9DN5GYQTh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=m7FktovAhJFjyCJv6RFkPp8xOI+MLfhjcktkrG4rhKcWQUeQB/Ref6GP4Q1NdQKLYnnBuPIOOShFsbiKWnjS8oNIq7hzu0hucSBipGX/KjPnHBJmXX/hPydE/mUhpsPCM8WsKojpTU/S08+0uQPrzhu4NgHNSb9UxJz62Im5n9bvjUQq1ysDKWbB1C5WwEj0QMTcUiCmPhoLfmGiAeTJA4I6UqJ+PAzHRWLK5UKF931HV4l5e0emyU2qdGUx8tPc4OiJGqfPGIQpdGRTv1DxCqvvcoo7MXKnyULvfOtvy1Npi2BMdrRvIZeOaaZKv5ANj0OHWiqpvTwhwakg7+qRnQ==
X-YMail-OSG: 76o.hcAVM1kwWEom9N00MW3VT.tW7TpXP8Z_hDZI4KiQYkItkzlBlJDLpw8dHRa
 AS_0o2lPrOuQFhrKkRXDdIdRoRt7qBY6ofGiJn2Y4BEuEm9YKYRCm81AMRhm1LV9wnE92pUApbdK
 TOAxYMc59y4ier_z7iTqMrtZtCEsZY_HRMsAznG1O0KrP2PjMKmkQ7zyFCDJW16AO0Ij.zqRXKr4
 GP3gtpcGyiLpd7sHNIR6x7La1Meb.mJC4ArSP_J_1Kc7Q0i2oUTQFVosV83GChAZS5eZoR20O2IK
 WyVU7Bh9qIObI3zoC7JcZUOLtotoJ4c5jHdoGt7IOAP3Dm4ImDxlsNLyl0rvDi14x9nIuAJbXf.i
 UB.EoX1TsF0yEEGx5y09_yAhSdhYgvAJSWAOk_zx3SMS1DCrJ0ykGYxqBrB0wrWOvKf37ll1nJrB
 9nE.uqRsT6AOT_AhlUoYSBVPEw1aVy5JI7IjlDZsmEXjDMC55a2awbyQG.q2q1KWy0HfxgOy0X_g
 NU6htUlcvsjaqs1rZVXveuna4CF_t5kYQtMbSxpWuHUpcWjOWQug6lq7z5GzrEV6SCcEys7M4ux6
 vZ7906jrdCczfzJcodfEG4peroEqqWhJodD0RUNfn8FT8WAFn0LZCbps2phWLK3ZcZuTSReyAAik
 KNMVF95Qhvu6H9xdA6lzZJ3j5mJ43Pf4LQNOd3ibGDndC4sAu6i91ljkpneifXQfX9sJZ8mKZVZK
 XJxx3bwPtly9VEG1_lD_TyAng.EpaNX88XyeLpk1SG_1QIfJYFUpEm4nEvRTUtMjMsyfDAodQXN9
 tm4yXIe4kVhueX4Ub267P91k3lRKUPcUr3yhVc6kB_lTLJ9gCu3Do6wVm2SLNxYFM7MjbbGQQciB
 n2VDk3.owRzafteglOoV70ZNi7Bk6S3BZEV70prYdneTn8xStbyfCLX5MLjlZopmW6wIMB6otSKE
 0k6jhSqyoVHf2QvGoxugsINBeVN6ArbRL69Mc_5Yp__6lswajfp2jCAfyDG7g2PfcwDZAB3X0Zea
 itYUYRMmm_2GUFC6ovy4kyB9omSb_K7j9q1Mt_HfCts0nkeyFkOH.tYJpN45A15uHkaBMcGPdvcR
 ubLeXetI6lJRMp2Qbh2qPkrndC1iTR8ajTY6piaQJoQxICRM1VlSrkkd3bcUDSGFJ.WK6ImvzANz
 rDjZNC5jr2am5Y2tq1RXkWOepQQ1ke5ZNUWX10ME0S.J_KZjiHrAzkFAL0naaskHYK5s2f9chtwd
 Eh0kWdihMau2Kru_Ejb2JXfqibPi42p_8yMyA88Kc86YS_lrRtwVG_bFExt2mm8DOvvokGAqIbVG
 or0kGAc28I_9cCBxBbftKx0az4bs7GMt1eYrFovwsdphLM1H2ikL_9DqWpSNXxQH_Snzr2UgQ7S3
 xekWeldEf8NOEdDd59PmLq.EDkN53FDMVYv9ojdRbZEhnhhChRb3I3swS1amUG06ncXawErfH1nR
 B3zlAA9Vy8V5lZcLCnsrKqYuPlh3RvxkOlLrwRRMrc4zeb7_PdEo0140raT8Jmo2d_OnUAYPCpMV
 4P0R7ML4r_VhVHspdG1p3OS1qq9T3P00BHl6yBxJ6ftQQRmuJHdiFzGt3MMlW2DAmAVMeL01SpXG
 xAyFXoZ08OsFgDB6NVOZLE7DVkKos3doUMv5xsiAhlOm8ZCFxp6S09cjNhiehFdk4WTJoGTlmBL2
 bGP2FLS9_yJyXWKt_nNBAifSYpzVMIzRaJXTL3FsrEmiZ1W7JfS.xKXMwZckGkSLR86Oz7eXJLGX
 nlXy8z6.Ln6moTj_r1L4Xad2pcvoyT7zqSLuPlndfBF2ovbq_fIwBPs7oPn4DaG9_V3Gh2vyb8HR
 kfwQBLSY9cJC5kyF5dvuUnc6UFdxUzBKGoL5cXx3TpuMU1wKxGivmUc1fneeBfVAkvF4bk6Vj7BG
 fvBF7TDwhdZ.L3FbTZQHyQwSD8IwDtOk5LsCOhHAncukmlQrL9YXMddwWcmuzcPpwvC5K9Kqmucy
 c3qhwe12tKZ8nRv4FgZ.FdsDaJyi77DVqnAC6XeFGgIWj7ozOrTq75Tywi1OQH0Ud8FOKmr4sfgU
 Cr9blz__c.xC4gQXxer8m6QlVEGPPgYDKZ1jL1OZGUiKHnhTXENsxTZlEZLFgBHmWOPC5v3h2Npu
 bZvyvbRmo8J7fVroz8kRDQvetZuHT4O1XzHKhNrppLgTEeS_6gxGbCtfoUJ369YoNzpQX1POdY9d
 PJMaWezd.uhui6nmcTP6N5v9ZYNjfaF_DYrvDKtHzucd0WJXs_NxqDZdZl3Ksi1M4Ib5B1FJRHMU
 oy1eJ9OLSxWIfjp8OuL0Ycw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ac71671f-ece0-4dfc-9555-2cc7c4704f6b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Jun 2023 21:34:29 +0000
Received: by hermes--production-ne1-574d4b7954-wtfnl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d3de0bf26e05d30f19b67b9529442c24;
          Thu, 01 Jun 2023 21:34:26 +0000 (UTC)
Message-ID: <e83ef047-42f3-260d-1ac1-07c576cce9f8@schaufler-ca.com>
Date:   Thu, 1 Jun 2023 14:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
 <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
 <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net>
 <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
 <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com>
 <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
 <e1db62f4-32c5-d784-ba4e-5acc242bc00c@schaufler-ca.com>
 <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
 <CABi2SkUFe7zOFi3Vr-A6bTGytOdeZkvsPfxxLq9+b0vHfa-bkA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABi2SkUFe7zOFi3Vr-A6bTGytOdeZkvsPfxxLq9+b0vHfa-bkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/1/2023 1:48 PM, Jeff Xu wrote:
> Hi Paul,
>
> On Wed, May 31, 2023 at 6:26 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>>>
>>>> If I understand correctly:
>>>> 1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
>>>> process's landlock sandbox status: true/false.
>>> There would have to be a new LSM_ATTR_ENFORCMENT to query.
>>> Each LSM could then report what, if any, value it choose to.
>>> I can't say whether SELinux would take advantage of this.
>>> I don't see that Smack would report this attribute.
>> I think such returned status for LSM_ATTR_ENFORCMENT query would make
>> sense, but the syscall could also return -EPERM and other error codes.
>>
>>
>>>> Is this a right fit for SELinux to also return the process's enforcing
>>>> mode ? such as enforcing/permissive.
>> Paul could answer that, but I think it would be simpler to have two
>> different queries, something like LSM_ATTR_ENFORCMENT and
>> LSM_ATTR_PERMISSIVE queries.
>>
> Hi Paul, what do you think ? Could SELinux have something like this.

Not Paul, but answering anyway - No, those are system wide attributes, not
process (task) attributes. You want some other syscall, say lsm_get_system_attr()
for those.

>
> Thanks!
> -Jeff
