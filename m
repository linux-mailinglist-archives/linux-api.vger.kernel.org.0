Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD822CE41
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 21:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXTDY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGXTDX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jul 2020 15:03:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8FBC0619E7
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 12:03:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so5007101pls.9
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f0lKwdFa2tE754eWyXOOIFz3gWD2EzuwPTrCttQ++tE=;
        b=HWLOLY2m7CMUOQYAp0GqUyHeBr+slwYCrPxK4fmOYzQKeY1Sqn9NsstNWgyO0gYfZz
         TUCLaYuoK1a5vP1C228zV0xEZgcjSBAnqzIr+6yAndPlXzf8D3bRRlqtGTaJ8eamUTu0
         m/nF3ewNlRWYDQ/wxxQHLPQatyOp/cmIjNB+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f0lKwdFa2tE754eWyXOOIFz3gWD2EzuwPTrCttQ++tE=;
        b=FmOftYF3FqjdkYLhvR6MfTYZpJM03yYmhCvgaKlxGWWNLRC6HdXjvBm7nIi6Pjpj4g
         WDFP6I6UBwt24sSt/1WrzhgDcjh7ybuefbfbrDqmj2/tDiX6Rg58Nt6bEd82QPABMqgg
         EHgoN9gaV50NG8BJnqPRRo86/m8CRTSHnMMjVBc8kPF6XYpwRR1Jm1/BZ+Wzhe8b/bDZ
         dSsuA+AXDdA+HLulyUtsuJ08dSwnkh2kA83V2XAa8FyPPlwY4GHs3LuHSEDvy579LIba
         2xHiALOx9H0Y/WRq55YFrSGjyYIrkfEibpY9Ud4kDRvfItYerVnPkfF/6H3hRlsmwO6f
         Pe3A==
X-Gm-Message-State: AOAM531aDxG3jYm0ktzDQwL60QEUAzHj+v3WGCv4p4Meko02zzNShmK8
        tg0+7qHu9VVR4YpEAF6PCOrNXA==
X-Google-Smtp-Source: ABdhPJyQSqTNd3BVzP4VWxiWnp6p6oQzAmDBIOJnaoSdP+OBPVoNfaPuvwcTsPgk9o7oKdilefLQ/Q==
X-Received: by 2002:a17:902:c252:: with SMTP id 18mr9772518plg.39.1595617402829;
        Fri, 24 Jul 2020 12:03:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm7283037pfj.104.2020.07.24.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:03:22 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:03:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 5/7] fs,doc: Enable to enforce noexec mounts or file
 exec through O_MAYEXEC
Message-ID: <202007241203.0C596BB36@keescook>
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-6-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723171227.446711-6-mic@digikod.net>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 23, 2020 at 07:12:25PM +0200, Micka�l Sala�n wrote:
> Allow for the enforcement of the O_MAYEXEC openat2(2) flag.  Thanks to
> the noexec option from the underlying VFS mount, or to the file execute
> permission, userspace can enforce these execution policies.  This may
> allow script interpreters to check execution permission before reading
> commands from a file, or dynamic linkers to allow shared object loading.
> 
> Add a new sysctl fs.open_mayexec_enforce to enable system administrators
> to enforce two complementary security policies according to the
> installed system: enforce the noexec mount option, and enforce
> executable file permission.  Indeed, because of compatibility with
> installed systems, only system administrators are able to check that
> this new enforcement is in line with the system mount points and file
> permissions.  A following patch adds documentation.
> 
> Being able to restrict execution also enables to protect the kernel by
> restricting arbitrary syscalls that an attacker could perform with a
> crafted binary or certain script languages.  It also improves multilevel
> isolation by reducing the ability of an attacker to use side channels
> with specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g., Python, Perl).  To get a
> consistent execution policy, additional memory restrictions should also
> be enforced (e.g. thanks to SELinux).
> 
> Because the O_MAYEXEC flag is a meant to enforce a system-wide security
> policy (but not application-centric policies), it does not make sense
> for userland to check the sysctl value.  Indeed, this new flag only
> enables to extend the system ability to enforce a policy thanks to (some
> trusted) userland collaboration.  Moreover, additional security policies
> could be managed by LSMs.  This is a best-effort approach from the
> application developer point of view:
> https://lore.kernel.org/lkml/1477d3d7-4b36-afad-7077-a38f42322238@digikod.net/
> 
> Signed-off-by: Micka�l Sala�n <mic@digikod.net>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
