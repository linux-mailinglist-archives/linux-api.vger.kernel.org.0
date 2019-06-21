Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C334D4EF88
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfFUTht (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 15:37:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35730 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUThs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 15:37:48 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so264403ioo.2
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g157EWPM9+4Os1nBGoiF1OQy1TbidUT7W+UG0Yj1JZ8=;
        b=Ui+c355nGw/Pzq4W8mFUBqWcPIznrn5gEe+HgqtrvwaK3ZTNfZXljqddkioUIXkVoQ
         fdHMP1jo2wLJfp8K17rKiHU7H609oNwo+2cnEciHQjAsnM/1cev6eVH0qui5gh52xYIN
         poBdIOvP/QbzCSO0pFWawgB74WM+scaVtIGkZOWhNCEwtgnxwGO4smkvWtAYCYMRBc76
         aSeKVPIUUKtMCOMFkV9jctYVXQZ8glK6bmgdCVddVNqa5kwUkKVZEvhWwc0dWI6QMKSk
         oTpGzRg2eECWzTQBupoMyAIJZLEUeSP4lH8xyW5OTDPYgwS7nvC/9R84Uu+wxJMcFgHz
         HvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g157EWPM9+4Os1nBGoiF1OQy1TbidUT7W+UG0Yj1JZ8=;
        b=NnytrXzU0r+NBYEdl9Rhh6+cWNqihwAt2MsNuTjgVExaxdnDr7x2CYRxUU7SOQCBTw
         uV/4+kkOOE1FllY9ws41mFz+hSwFSFoaMGDwili/76oYTXXJnowLj7aRCnDGqqm0XPQw
         0bK7PWoE+9IzjzxVv/2U7vFBljIj9Yiga+n1Vwr3mc3m4tVvdevFRWzU2iRkuKCMyfst
         A8Xhu592WThk/9ZSB9o83d7R+NuNqlRmiOdEYfV0AUIEepHso7OpfYvxuqLGHsDvWrFF
         iCSLHn1c/A7yffFRtDhNZgvv8WdOyQ+am65F8lrUG1Lc0QSVw+l1rulKnOYAMIqQ0yY+
         dBRA==
X-Gm-Message-State: APjAAAVu4LV2De6GukV8kToa6zgHZsJBxzHaHd3JaRq/j4NArtTfmWT3
        XMCVmXeUdnltu5Mt98e7uMnQ3DOamB6zSsYpGj0xig==
X-Google-Smtp-Source: APXvYqxS1ovex+5dBomAz4bV36QcWQv4dhYR2sjJI/In/DVPcORFH++/waHkU1ZRBbCT7W+1Tp89flH1UZInkdQrAeA=
X-Received: by 2002:a02:3308:: with SMTP id c8mr44410773jae.103.1561145867511;
 Fri, 21 Jun 2019 12:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-4-matthewgarrett@google.com> <201906202028.5AB58C3@keescook>
In-Reply-To: <201906202028.5AB58C3@keescook>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 12:37:36 -0700
Message-ID: <CACdnJut_C_h2JjryDxEm9U_rpSJFkVyxq3iCW9=AhwcdVig=9g@mail.gmail.com>
Subject: Re: [PATCH V33 03/30] security: Add a static lockdown policy LSM
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 8:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 20, 2019 at 06:19:14PM -0700, Matthew Garrett wrote:
> > +/*
> > + *  If you add to this, remember to extend lockdown_reasons in
> > + *  security/lockdown/lockdown.c.
> > + */
>
> Best to add something like:
>
> BUILD_BUG_ON(ARRAY_SIZE(lockdown_reasons), LOCKDOWN_CONFIDENTIALLY_MAX);
>
> to actually enforce this.

I don't think this will work - it'll only catch cases where someone
adds a new enum after LOCKDOWN_CONFIDENTIALITY_MAX.

> >  enum lockdown_reason {
> >       LOCKDOWN_NONE,
> >       LOCKDOWN_INTEGRITY_MAX,
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 1d6463fb1450..c35aa72103df 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -236,12 +236,13 @@ source "security/apparmor/Kconfig"
> >  source "security/loadpin/Kconfig"
> >  source "security/yama/Kconfig"
> >  source "security/safesetid/Kconfig"
> > +source "security/lockdown/Kconfig"
> >
> >  source "security/integrity/Kconfig"
> >
> >  config LSM
> >       string "Ordered list of enabled LSMs"
> > -     default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> > +     default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>
> Is this needed? It seems like the early LSMs are totally ignored for
> ordering?

It's relevant if it's not configured as an early LSM.

> > +config SECURITY_LOCKDOWN_LSM
> > +     bool "Basic module for enforcing kernel lockdown"
> > +     depends on SECURITY
> > +     help
> > +       Build support for an LSM that enforces a coarse kernel lockdown
> > +       behaviour.
> > +
> > +config SECURITY_LOCKDOWN_LSM_EARLY
> > +        bool "Enable lockdown LSM early in init"
>
> whitespace glitches?

Fxied.

> > +static enum lockdown_reason kernel_locked_down;
>
> What's the use-case for runtime changing this value? (If you didn't, you
> could make it __ro_after_init.)

Cases where the admin wants to make the policy more strict after boot
via securityfs.

> > +     for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
> > +             enum lockdown_reason level = lockdown_levels[i];
> > +
> > +             if (lockdown_reasons[level]) {
> > +                     const char *label = lockdown_reasons[level];
> > +
> > +                     if (kernel_locked_down == level)
> > +                             offset += sprintf(temp+offset, "[%s] ", label);
> > +                     else
> > +                             offset += sprintf(temp+offset, "%s ", label);
> > +             }
> > +     }
>
> I thought there were helpers for this kind of thing?

I'll check, I'm bad at finding these new fangled things.

> Ah, I see now: it *might* be an early LSM. What states are missed if not
> early? Only parameters? I think the behavior differences need to be
> spelled out in Kconfig (or somewhere...)

Ok.
