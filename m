Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E46313DC4
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 19:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhBHSks (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 13:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbhBHSkW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 13:40:22 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1806C061788;
        Mon,  8 Feb 2021 10:39:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c132so10804387pga.3;
        Mon, 08 Feb 2021 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXsP7etvkquZcgLN+0ZBxKek7pWgCF6Ku7uGUtKs97I=;
        b=icFUkUZSlauoM1BcKvcJzDZLoo8oo1wZ+HtBsaFkgDhDjF9+P3Oezy9+bt52sdLtV1
         Zoz79tnmx+uRhxgw8ZGE3QqFsRiXTpcQkpN8Av/i+gUOsw8fBVMiiZ0WamTWJbPC4LwA
         wiT4CInCqo+OtLbwbAx4SnBXuSY12diFilkpepCOac5aUXh+tpgxnMl15asmx4j/nrNN
         SihUmP3RhZpWUzQHA873Vm3QvvP9oz2bb8+sNXNITu7+X2qFDFRDmV3xjiMTPnFAJ/7D
         Ui3M/Wbjv2XdZRTzHNqh90b0A3E2sq/EZ+UmIm48/9cH+MAXXRtVw87EI+UbAKQbwNYG
         /kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXsP7etvkquZcgLN+0ZBxKek7pWgCF6Ku7uGUtKs97I=;
        b=V1VZgxjc5x+dfMDV2lfM9zZiCfOztIeUhK9AfQOYgvl6htb1+SDwWNvwpoaLby27AG
         A2uhe5K3otVWd9tjkIQhBdbcQz5S+fHWDE4V7IWZzFp2HJGkQadGpYipE7rR2YeHDK+o
         nNX2W+fE8LVdDx55v9KA9rZ40nLBl9LUxOiXmZK3QvT+hFvAALVA351UrX3UJKaTcW5u
         CSkaQkSINUAdMaJqjbSALX00nQ2HWpCNp9piF21Ks4JYiheNtvEgKh8feO4IjVNKvmhf
         lmaXShwxywBN3sDUC5BNGAsz9s+YHZ+97cheFM8AAzXbr4wuC7V+2QFCgmIgvPgkeNn2
         gQmg==
X-Gm-Message-State: AOAM533QcyxpmHWtRUzC1mAw7JHAHwdpTHJY8XrK3zFgP5CNXBxoR6wK
        ZHNXMUGaSeVsLYvktkHAuXE=
X-Google-Smtp-Source: ABdhPJzZJmkotHvueFLxVOfrROL778amS3T+8zb8OezYdn81GGHSUROAUWugiwoa3hMKn176NcODwg==
X-Received: by 2002:a65:44c5:: with SMTP id g5mr18523114pgs.295.1612809580033;
        Mon, 08 Feb 2021 10:39:40 -0800 (PST)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id c23sm9222470pfi.47.2021.02.08.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:39:39 -0800 (PST)
Date:   Mon, 8 Feb 2021 10:37:52 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>, Kyle Huey <khuey@pernos.co>,
        Robert O'Callahan <roc@pernos.co>
Subject: Re: [PATCH 0/3 v2] arm64/ptrace: allow to get all registers on
 syscall traps
Message-ID: <20210208183752.GB559391@gmail.com>
References: <20210201194012.524831-1-avagin@gmail.com>
 <CABV8kRzg1BaKdAhqXU3hONhfPAHj6Nbw0wLBC1Lo7PN1UA0CoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CABV8kRzg1BaKdAhqXU3hONhfPAHj6Nbw0wLBC1Lo7PN1UA0CoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 01, 2021 at 07:11:12PM -0500, Keno Fischer wrote:
> Hi Andrei,
> 
> > This series introduces the PTRACE_O_ARM64_RAW_REGS option. If it is set,
> > PTRACE_GETREGSET returns values of all registers, and PTRACE_SETREGSET
> > allows to change any of them.
> 
> thanks for picking this up. I meant to work on this, but unfortunately ran out
> of time to be able to push it through, so I'm glad you're working on
> it, since it
> does absolutely need to get fixed. Besides this issue, the other problem we
> ran into when trying to port our ptracer to aarch64 is that orig_x0 is not
> accessible through the ptrace interface on aarch64, which can cause tricky
> behavior around restarts.

Could you describe the problem in more details? I wonder whether we have
the same thing in CRIU...

> We managed to work around that in the end,
> but it's painful. If we're fixing the kernel here anyway, I'm wondering if
> we might want to address that as well while we're at it.

Sure let think how to do this properly.

In this case, I think the ptrace option isn't a good choise. I don't
think that it is a good idea to change the layout of regset depending on
options...

Thanks,
Andrei

> 
> Keno
