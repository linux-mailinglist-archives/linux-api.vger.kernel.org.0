Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2F623787
	for <lists+linux-api@lfdr.de>; Thu, 10 Nov 2022 00:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiKIXem (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Nov 2022 18:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiKIXed (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Nov 2022 18:34:33 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BC02E9CE
        for <linux-api@vger.kernel.org>; Wed,  9 Nov 2022 15:34:32 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q83so216174oib.10
        for <linux-api@vger.kernel.org>; Wed, 09 Nov 2022 15:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXS9MQPdcmgJY+EAqnfOGCHBzGHHvIikozxUjDfYtaE=;
        b=GaM82nIY9C40LQ1/RGMLX1U+cZtVw34qLtDGxSVGU0CcCpJv7d1R4KiH+Y6EeJxdYn
         Um7JDSTp4vB5LdkQizSVM37pcrdnUcaGdSxxFi3dKtAmY/xTiowC45el6e7egLEC4o5t
         opUX2yj2c0kIdzSnMfVbRtC0NPSuE/pvoY8kpOpTHnPdFV87LlVmBaWiNsdpOOvM+Dnk
         Qlj+B/9iDYO06cOqeEHJftH4PoW5+Sa0Bc7M8ZFCvQCzVpyGxzb5hbnR5/Bta3ra6k+4
         mStPVLSDBse05LBEFLDk+te8ZgYyxQDqZm1i507VfT+BLpJjlYoUMuu82dbxkjr7Ml1A
         fBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXS9MQPdcmgJY+EAqnfOGCHBzGHHvIikozxUjDfYtaE=;
        b=0UiiLu0SGqTfY1P6alhneEpEUa+gMKVgPm42jHvv4/VlzEFZaS5nKLSudbU60brV/q
         s9IjZBK8Tbk6pKqwkFTaYLP0Hxd03hX8k3UW3fPYoaOJNfRHK/w8Trwr5AdYlg6UQD2r
         I6qjcHdIcEZUPsQglVw3L/oyvAcRGaJnWMFxbPgDV9ypo84A3mF+v6RqkDDKiqeaJr7A
         m2YPg4IhYRk2+8HuzBppSB/vq6Z1iy814Ka7mVK1phxT4kRHoL51snxZ7W3rAos3iK9y
         g4z8/xc4010ekurcAvSUK0oRvjQuLYbRKHKNCx0vFHHnZHlQ2DIrxvfYj7cOey+b901S
         eRPQ==
X-Gm-Message-State: ACrzQf2by4s/3+VA8s1Ahu7KSMwyqg02UQJsOTKNMetjw0IUnnHDkjT/
        ytjpBkZExLUm5ejTSZQkxQ3JIGRM5s3pcmmwbL2y
X-Google-Smtp-Source: AMsMyM6TjUpsQIXI5cARZVmGqCvDmYQLxaSyjADOqImV5Vmi0pMiLjwzwN4Ld6s8w5576mOzGn108NdoR2Gkjaxy2Ko=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr20276345oiv.172.1668036872142; Wed, 09
 Nov 2022 15:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com> <Y1jNGMKfb+NUPrJS@kroah.com>
 <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com> <Y1olXIbTGx9NnthU@kroah.com>
 <d545ef2a-5cc5-2848-e699-ff791d34d7c7@schaufler-ca.com> <Y1q8SzpcdWgm/fLq@kroah.com>
In-Reply-To: <Y1q8SzpcdWgm/fLq@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:34:21 -0500
Message-ID: <CAHC9VhRv=o98MsYzYLZ+uHhvr6GxiX2tgkK07EEFdHnxWMSP7g@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 27, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Oct 27, 2022 at 10:08:23AM -0700, Casey Schaufler wrote:
> > On 10/26/2022 11:29 PM, Greg KH wrote:
> > > On Wed, Oct 26, 2022 at 05:38:21PM -0700, Casey Schaufler wrote:
> > >> On 10/25/2022 11:00 PM, Greg KH wrote:
> > >>> On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
> > >>>> As LSMs are registered add their lsm_id pointers to a table.
> > >>>> This will be used later for attribute reporting.
> > >>>>
> > >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > >>>> ---
> > >>>>  include/linux/security.h | 17 +++++++++++++++++
> > >>>>  security/security.c      | 18 ++++++++++++++++++
> > >>>>  2 files changed, 35 insertions(+)
> > >>>>
> > >>>> diff --git a/include/linux/security.h b/include/linux/security.h
> > >>>> index ca1b7109c0db..e1678594d983 100644
> > >>>> --- a/include/linux/security.h
> > >>>> +++ b/include/linux/security.h
> > >>>> @@ -138,6 +138,23 @@ enum lockdown_reason {
> > >>>>
> > >>>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> > >>>>
> > >>>> +#define LSMID_ENTRIES ( \
> > >>>> +        1 + /* capabilities */ \
> > >>> No #define for capabilities?
> > >> Nope. There isn't one. CONFIG_SECURITY takes care of it.
> > >>
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> > >>>> +
> > >>>> +extern int lsm_id;
> > >>> u64?
> > >> u32. I doubt we'll get more than 32K security modules.
> > > These should be bits, not values, right?
> >
> > lsm_id is the count of security modules that are registered.
> > It seemed like a good name for the value at the time, but as
> > it's causing confusion I should probably change it.
>
> Yeah, that's confusing.  "lsm_num_availble" might be better.

Yes, this really should be named something else.  I'm partial to
"lsm_count" as it is shorter than the other suggestion, but this is
hardly something to worry too much about.

--
paul-moore.com
