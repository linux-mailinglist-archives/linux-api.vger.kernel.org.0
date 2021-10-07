Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442AD425B78
	for <lists+linux-api@lfdr.de>; Thu,  7 Oct 2021 21:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhJGT13 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Oct 2021 15:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhJGT1X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Oct 2021 15:27:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B5C061760
        for <linux-api@vger.kernel.org>; Thu,  7 Oct 2021 12:25:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k26so6181958pfi.5
        for <linux-api@vger.kernel.org>; Thu, 07 Oct 2021 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/n8Me6J9c/0Aaoq12l4632VyTlikQYiCethpuj+aLbY=;
        b=SQli1vTaGmeF3OtZ3pEx09pCBMoHEts7mbTOISN2rhw8hmBquS/IZbR87v5QBBLbqv
         /pqrMUBoSis9z+SqnCrcggOh95LPt3XnzSnyEUY5qxiV3KUqfrJavcG97WH/T17gpSTR
         ocgOZSBiyES6Ow7gBhMre0GdCndxIz5XD9k68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/n8Me6J9c/0Aaoq12l4632VyTlikQYiCethpuj+aLbY=;
        b=zW0eHmRnRVqaCUXyQd5/wHfiplFjHeIiub/VePcxAUpcT1Raoco3/u5qhChlI9Do7B
         ZWjg3H2cFED/Ag6P7gFifsUdW/ZiiyfFcWr+dJ7xoYHz5WeDpeWSAHbv8qNGVE+7Jjqq
         fkDrQ7te9U6fOklhsHWx9F/P5JsOCitDZxvKbNvOugDjiOnuHo+zidyBjMVLYl1bHhmK
         eASIk7aqJas9VMV4Qaa9cvemptawIasTijMYQsdcFZhF36Yhwe5qQJZr2TuUC/MYsm/Z
         0AcVM9V0onTeN537zU6Jip6E7ZdiOw8F4PR2KpiVCI00IDSfMqEFXIfLk1BBK9I3UA5j
         xewA==
X-Gm-Message-State: AOAM531Gwt93pX/aut6ULxv8yIClA1Zs01Lrng4BDzuWKKgcAuuDr9fN
        6gn51GdaN1+1phNqiz/Ok4FGSg==
X-Google-Smtp-Source: ABdhPJyWbT/2wfJkhN3zmahv5/28fdw9q8dBvfcBa/rkLKicY5/v7uqqy3nFOrQlBaExCnpIUB7yjQ==
X-Received: by 2002:a63:7118:: with SMTP id m24mr1146122pgc.332.1633634728739;
        Thu, 07 Oct 2021 12:25:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm9790176pjl.15.2021.10.07.12.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:25:28 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:25:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v13 1/3] fs: Add trusted_for(2) syscall implementation
 and related sysctl
Message-ID: <202110071217.16C7208F@keescook>
References: <20211007182321.872075-1-mic@digikod.net>
 <20211007182321.872075-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007182321.872075-2-mic@digikod.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 07, 2021 at 08:23:18PM +0200, Micka�l Sala�n wrote:
> From: Micka�l Sala�n <mic@linux.microsoft.com>
> 
> The trusted_for() syscall enables user space tasks to check that files
> are trusted to be executed or interpreted by user space.  This may allow
> script interpreters to check execution permission before reading
> commands from a file, or dynamic linkers to allow shared object loading.
> This may be seen as a way for a trusted task (e.g. interpreter) to check
> the trustworthiness of files (e.g. scripts) before extending its control
> flow graph with new ones originating from these files.
> [...]
>  aio-nr & aio-max-nr
> @@ -382,3 +383,52 @@ Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
>  on a 64bit one.
>  The current default value for  max_user_watches  is the 1/25 (4%) of the
>  available low memory, divided for the "watch" cost in bytes.
> +
> +
> +trust_policy
> +------------

bikeshed: can we name this "trusted_for_policy"? Both "trust" and
"policy" are very general words, but "trusted_for" (after this series)
will have a distinct meaning, so "trusted_for_policy" becomes more
specific/searchable.

With that renamed, I think it looks good! I'm looking forward to
interpreters using this. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
