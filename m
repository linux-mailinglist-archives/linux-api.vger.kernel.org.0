Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422233453B2
	for <lists+linux-api@lfdr.de>; Tue, 23 Mar 2021 01:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCWAOU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Mar 2021 20:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhCWAN6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Mar 2021 20:13:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C67C061763
        for <linux-api@vger.kernel.org>; Mon, 22 Mar 2021 17:13:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u10so23344229lju.7
        for <linux-api@vger.kernel.org>; Mon, 22 Mar 2021 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Zv/Nh1NwdjT4vNoEgAKJF0+3Ir6H8KTDS01ZyTPf3o=;
        b=MYfMpOlaWILZRe1pDeuZweAI3vdknsgeo67laT+dKd7DkSPJ3kqkICjvz6DoYVVnHZ
         16OeAVHxuQfaEw3tjPMoe7QoNfBgXwLH10I06HQvLQrqH5L2JNBJAwiEQ2JR4BIEX+9S
         mKRD0C7UQTjhxOy/6H8fA1YjCpW2EGV+O/1qAjuqnz/pmrLszTPkOjvS0yYpv/ZZ/qEF
         lAjiGv9YsocO9v0uFbeqK3kItyVLmzZ8XbFjbvISEZUv72q4Dv/aYT92AgSreyZJuLpZ
         d2c1Ghef/K4UviwHxjZHI5pznTsVIQq7ZchuSPAoEZC7/qFfjBKUTKzfd7IBKdOJs9LE
         ySlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Zv/Nh1NwdjT4vNoEgAKJF0+3Ir6H8KTDS01ZyTPf3o=;
        b=cwy9fVsFuOkNslb9qipcCAvRmq0p8ag3wpGboKLA1cMVrJV1Ud5GTJnI6sMZ/3T6oB
         ybty4pKcCiFYFKYaJduPol8BnZ+XpTvhOKK8XeR4mglTzlAsd0z2+Bq24/hr69AydZFr
         EJc1aQ6CLXlF8Au+YDPZp08bNTtSALxpMXjngQEflq0Bd2xWZ4c0RM7vX3H7BK1bsF/p
         G/pYbB+gulfUb9MOvTqonp9kKdr9Xvayrs8w+Zxb+ujCYF2g3pm3Zy4kLXD5DK9cl+qc
         J1U8ym8WOHuFJ0OZ7GquTarCk/KWwKifzRvE3Atrvbt92kSFyQUq01snViYyus6rF/7+
         3LVQ==
X-Gm-Message-State: AOAM532+oGActpTu7x7HvIEtm4S0+QpW5S4rgT+UJrWlb7iRhy4MpX4+
        gLxwbOCf80O5tDXaGJvRP3RGydzoPKYt6wlgplXnZg==
X-Google-Smtp-Source: ABdhPJywL/8xL+s/Wz9PYQqACsNKJlIixpOZzrkkMLprtEmtD0taXBt0RZSmBTlrPE/s8ZHyKoeWgqn3ctd+1W/a4Oo=
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr1219196ljj.43.1616458434230;
 Mon, 22 Mar 2021 17:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204252.427806-1-mic@digikod.net> <20210316204252.427806-3-mic@digikod.net>
In-Reply-To: <20210316204252.427806-3-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Mar 2021 01:13:27 +0100
Message-ID: <CAG48ez3v44du6_qVLa25SOdfLsr5+z-=a0pUP63d=qHP2tf4Pg@mail.gmail.com>
Subject: Re: [PATCH v30 02/12] landlock: Add ruleset and domain management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Mar 16, 2021 at 9:43 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock ruleset is mainly a red-black tree with Landlock rules as
> nodes.  This enables quick update and lookup to match a requested
> access, e.g. to a file.  A ruleset is usable through a dedicated file
> descriptor (cf. following commit implementing syscalls) which enables a
> process to create and populate a ruleset with new rules.
>
> A domain is a ruleset tied to a set of processes.  This group of rules
> defines the security policy enforced on these processes and their future
> children.  A domain can transition to a new domain which is the
> intersection of all its constraints and those of a ruleset provided by
> the current process.  This modification only impact the current process.
> This means that a process can only gain more constraints (i.e. lose
> accesses) over time.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/r/20210316204252.427806-3-mic@digikod.net

Reviewed-by: Jann Horn <jannh@google.com>
