Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5E2BBD94
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 08:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKUHAY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKUHAX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 02:00:23 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696E3C0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 23:00:23 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so12386633ljo.11
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 23:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X7o0m3hQXVmVofbCR6L473p8htdBcLYyTWc2pJqZOUM=;
        b=NAf9nl2J7IrdmpQMU2t/+SODdOjUjzxQqsSksle5M3l6Ywri6/LWuLY60ItJmETxox
         z2485qDtzcZq4U8ptX5mV32Ds+iGsHITL/G++mgluYxor/atna2PNO96gnuZ9eSDli3A
         5YrOYozkM2esFvaUNe2lQ0jxlcdKo64nZZ8pWX8rKG3JIFhXACukB9nxastIxuNvxQwi
         m72FEnkLoHzVUECvi7NKtdHoiQma263Ss/twJenvsetmtxc+Fz3/ib+Kowi86tegJZ9T
         L5IzUl6TiURt6iNTyUYZjfH9tlL3oH6hVOmtT19/HgNgWR2EhrXZODwaZrS85DwyHUuy
         aGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X7o0m3hQXVmVofbCR6L473p8htdBcLYyTWc2pJqZOUM=;
        b=FjWEKJWHuJatjSnabMa7rT68igV/xVnTZWxKqg/GJQHLJtydHC7uR3hgoEhJG9ONVf
         v2MapYPpigaJTHeE08WhzomaF/0ehSyjy1YME47EVpvetF9b8iTxOj3G4HvzikcyULgT
         g0kJH6sKGtCxNkZli/mtg3rd1ZTnYXt6cKHh11Goh9VQT8rZVgIGFQZX8OH4MktTTUn4
         aomgrSxxt4pSimHqpBsmjIpZZpqVQIJAgIblGCrL4qRRiZTfL8ohtmv1NGWVG8e0DrlW
         XgI39Vj4f4FGRCxzD21A9N0IaKnEaiP7+8WM++nYHih/UQGAwOlh9qZ5vEFwog5nej92
         /Q9Q==
X-Gm-Message-State: AOAM532s60XvTprOTa2pRdIeiz8fB/g9i6NKoJx9JvJuH9KntfHfYsnZ
        4gTqQ1RD2xya8y9sqGqVvryDJLuMqu+K8HocDQjLwQ==
X-Google-Smtp-Source: ABdhPJyQlluKPoz0OIWNJejUmA2oBeD6J48fIKEWng63DXZFe9Wj5F7lo9xUW1sQakHx3A+Zc/rgyFU8fgOEwoYO4Ic=
X-Received: by 2002:a2e:8350:: with SMTP id l16mr9449286ljh.47.1605942021665;
 Fri, 20 Nov 2020 23:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-2-mic@digikod.net>
In-Reply-To: <20201112205141.775752-2-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 08:00:00 +0100
Message-ID: <CAG48ez0GryN4i0xCP22utLTqF5_o5J3nMBs+VC0DpQ+s09Bx6g@mail.gmail.com>
Subject: Re: [PATCH v24 01/12] landlock: Add object management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 12, 2020 at 9:51 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock object enables to identify a kernel object (e.g. an inode).
> A Landlock rule is a set of access rights allowed on an object.  Rules
> are grouped in rulesets that may be tied to a set of processes (i.e.
> subjects) to enforce a scoped access-control (i.e. a domain).
>
> Because Landlock's goal is to empower any process (especially
> unprivileged ones) to sandbox themselves, we cannot rely on a
> system-wide object identification such as file extended attributes.
> Indeed, we need innocuous, composable and modular access-controls.
>
> The main challenge with these constraints is to identify kernel objects
> while this identification is useful (i.e. when a security policy makes
> use of this object).  But this identification data should be freed once
> no policy is using it.  This ephemeral tagging should not and may not be
> written in the filesystem.  We then need to manage the lifetime of a
> rule according to the lifetime of its objects.  To avoid a global lock,
> this implementation make use of RCU and counters to safely reference
> objects.
>
> A following commit uses this generic object management for inodes.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Reviewed-by: Jann Horn <jannh@google.com>

Still looks good, except for one comment:

[...]
> +       /**
> +        * @lock: Guards against concurrent modifications.  This lock mig=
ht be
> +        * held from the time @usage drops to zero until any weak referen=
ces
> +        * from @underobj to this object have been cleaned up.
> +        *
> +        * Lock ordering: inode->i_lock nests inside this.
> +        */
> +       spinlock_t lock;

Why did you change this to "might be held" (v22 had "must")? Is the
"might" a typo?
