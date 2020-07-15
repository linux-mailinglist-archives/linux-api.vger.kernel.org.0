Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF52522165F
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGOUit (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 16:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGOUir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 16:38:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9AC08C5CE
        for <linux-api@vger.kernel.org>; Wed, 15 Jul 2020 13:38:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so3662387pgg.10
        for <linux-api@vger.kernel.org>; Wed, 15 Jul 2020 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qTkObtIP1JOxTsAafQAu4JRP/2PqoQenw/nsfCYT+XA=;
        b=ijKpH2WTKasm1SeJa7YfW41RoND4SGhxfWW8WIrBUyWAJo5mncDz3F6DsdpLNbN9yM
         zimIQJdAwdsoIuaoAmdGi8bqgFGbI1ImDdJTj84SXvxwzifKGWR/ToGmegNpJJRYxabz
         0Mzoe5AOfjDlUoukmWy/DGwdgH+42OpxYqawc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qTkObtIP1JOxTsAafQAu4JRP/2PqoQenw/nsfCYT+XA=;
        b=bbzUpqPMqe/rk591ApypvzAfrDrlUJKGKXwbuY7vefOZ0+9iFwVs4IwHcP31g77yks
         lg/4eezX+7wJtlzw11C2/4MtrFUXkjhBNYMMrKqhMywtaG2q9hDgDOeTDXPUQNbljddk
         XXRWc270N51pfoD9yHqENkVJrUuuwZ8ffqkCOwFF9+fWE2mzFhGCCepWAzYPMOajsxSu
         SzdWAXvN7Rlw/c8MoDnM6ThWDJMizYftiogAvB/7jIFXVx+JcnBMez4dpugeeSsAKoXA
         X3kcGL2Qz3bNxpG7kGS80/waKbLD4hxatquXzWZAlAhQDvy1G6cb9qVzsuiJJWuE5HDB
         5cOw==
X-Gm-Message-State: AOAM531BASPf286JM8gtbzy2a1fHgKihBk2QkQlxXmOVAD0y9Z0qnjtV
        DwrkTufIZicrRfHb/JbLvYdrTQ==
X-Google-Smtp-Source: ABdhPJyOe9mUdiu/xb+eBR+7MVDzMD0v9uEBAElvlLK4fUJtk8fgRzbG6NWh1tQpT587gudq9JBjRg==
X-Received: by 2002:a62:cdc4:: with SMTP id o187mr922387pfg.200.1594845526528;
        Wed, 15 Jul 2020 13:38:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm2962482pfk.171.2020.07.15.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:38:45 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:38:44 -0700
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] selftest/openat2: Add tests for O_MAYEXEC
 enforcing
Message-ID: <202007151337.2A113F8C@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714181638.45751-7-mic@digikod.net>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 14, 2020 at 08:16:37PM +0200, Mickaël Salaün wrote:
> Test propagation of noexec mount points or file executability through
> files open with or without O_MAYEXEC, thanks to the
> fs.open_mayexec_enforce sysctl.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>

Yay variants! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
