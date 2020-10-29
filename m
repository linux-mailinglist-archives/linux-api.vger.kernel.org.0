Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27629E000
	for <lists+linux-api@lfdr.de>; Thu, 29 Oct 2020 02:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbgJ2BHV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Oct 2020 21:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404156AbgJ2BGg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Oct 2020 21:06:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C4C0613D3
        for <linux-api@vger.kernel.org>; Wed, 28 Oct 2020 18:06:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so1156159lfp.11
        for <linux-api@vger.kernel.org>; Wed, 28 Oct 2020 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pn1ECaKgjWXcAj9IGY9xa/P/urhrG9XYha2Ze81haPI=;
        b=CQS/TTCSV/PXnE8RKTiVdoB9MOH5R7RwtttysBDMDTrgm/gdARB43BDZ0IDwXRbttP
         ztHZD+0ZqXCLCfwhTBFjTJ/tiDFdE5MfzqiqiGCR+7qo4iT6gbpszW4gnmqQCqcjiJpS
         2TE6AWWOiPiIHtCacy+jotlH1GyWUK1IMX8yXc8Mz7No8vs/C8JnIaRhweaK8oe5/GL8
         Jfgwtgs4gp/wo+Iw7O3nmUyVGt/oQ9DoZH/ghQZ47kjp3G1BZkOXJfz4E7+ioxLBPKqf
         wNABOnStf+0wcuigg1mHsL0KxMLpB2iVoTZoknuLmehB39wLMOwYtSz1o0w4ntAQ9dSd
         hmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pn1ECaKgjWXcAj9IGY9xa/P/urhrG9XYha2Ze81haPI=;
        b=J/8bIWkOPaPooRXZTADq/mi7u+ZyQdBtCvJERMDcTYphVTiKpg7e1RsMR1PNCpVNql
         8+xUF8TbaEox9u0sEGqvB2ZVq9aC6GgMHjmUCmeItJ7YgzsZ2Uq3k+j42xW6HwSq5vLc
         9gXV3VyxyQRb/KtLznh68WhLCd/Rnouoqz7oCwvVZPfmhyt5qEh41s+lZpzjECeBFn54
         olGLe+u1HIYaHMcS+6N7DpaGSyIztkGDGBbVdmSRgD8QgnTPVxjWcqhoG/zGvOXdKaIT
         x3Y5lj/LdikMF0bN6ZQPcuMaWE+hiGqJJt/VjzHQ/g2/hvNwTI2uDM50Fp/AnLdVxbOc
         Da2Q==
X-Gm-Message-State: AOAM533j0ZU9Yh2w7e4bmaL3ik4bsx11A9HqHPth/h0vGgC4rL4aEWd2
        CjJxpev311ip7BLalnswYqs7FxYRfC1XKGViFNAzKA==
X-Google-Smtp-Source: ABdhPJxixA+XOTBfZ3BYWY3Zb24muHdDJFJXA6IB2XijLR/mZHkSGkBIOx58SM+pLP1LMZ2g2O7vRP785516kejacuI=
X-Received: by 2002:a19:e308:: with SMTP id a8mr562788lfh.573.1603933593718;
 Wed, 28 Oct 2020 18:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-5-mic@digikod.net>
In-Reply-To: <20201027200358.557003-5-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:06:06 +0100
Message-ID: <CAG48ez1W2sHBeL4pV4QqUonUJc-snNnxE_jh8FVP=pyhhm0fdg@mail.gmail.com>
Subject: Re: [PATCH v22 04/12] landlock: Add ptrace restrictions
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

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> Using ptrace(2) and related debug features on a target process can lead
> to a privilege escalation.  Indeed, ptrace(2) can be used by an attacker
> to impersonate another task and to remain undetected while performing
> malicious activities.  Thanks to  ptrace_may_access(), various part of
> the kernel can check if a tracer is more privileged than a tracee.
>
> A landlocked process has fewer privileges than a non-landlocked process
> and must then be subject to additional restrictions when manipulating
> processes. To be allowed to use ptrace(2) and related syscalls on a
> target process, a landlocked process must have a subset of the target
> process's rules (i.e. the tracee must be in a sub-domain of the tracer).
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Reviewed-by: Jann Horn <jannh@google.com>
