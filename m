Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2114301E1
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE3S0v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 May 2019 14:26:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36186 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfE3S0u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 May 2019 14:26:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so2907657plr.3
        for <linux-api@vger.kernel.org>; Thu, 30 May 2019 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=479NrpI5Fpv8iNSEqJ5Iw1oq9Ng17zG9lbJXZZiDpy0=;
        b=Me4frF9wOzh8lEvpxZ+vU5EUYHAr4jOgS4hV4/+Jkt5CrHU3uvrkkrEJk1V/YWWY3c
         O1LeU+cx+xBxaGd3saLITg7VBE7sFN0iIWNHmc08B3n/Pa92mPLjpcam2qtui/OMGHdR
         yhNXhwF9tOi0AGMYVP4ueerYO83fR82m00jDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=479NrpI5Fpv8iNSEqJ5Iw1oq9Ng17zG9lbJXZZiDpy0=;
        b=lvjyYjXAk5adZKYR2vC8JggQe0h89Ckt5tPpu1tGtMwbCFjonsCmQ0F81f3l3GqMjy
         HA7YTsqW1LGD5UKoqLlAfj0o2vEmFhP1Tpk4FG1LcMnXKYNOvFVdNrlDC2lZj85DGXr3
         Rg99O2IBv1zAGCBBGdfIg9LWm7yk4t8Lcy2RiaAjFTbcQlULNHAiWLy9Tlb5z5OeqiG3
         4r1MGOJZ3QwF6eBiBmRHLvAF2MGg1Xu1ZnPvAaxWXjkY+1gcPn/HyWD26UG/ORd3eLS4
         FVDhn67ilfQjwPXdPEW66CkFXGlfG0WfPKzV1CqNUgR5b0gUpf9WwcmXXT1s51x35QwR
         1AdA==
X-Gm-Message-State: APjAAAUVjuxiCFKUNOqhcP/cqu0FvxxSIWg86zYgaOSSyW18sVm7BVUT
        Y/xdUkL+862deBVzmEu5kEop5A==
X-Google-Smtp-Source: APXvYqyHXrW5NCEsy8spGMlIWgFWxdYS/BWA/cI4wEZ5qBofJ864Jbzeza81bYct/2aQTQraJavC3A==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr4639420plb.143.1559240810223;
        Thu, 30 May 2019 11:26:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m123sm3886620pfm.39.2019.05.30.11.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:26:48 -0700 (PDT)
Date:   Thu, 30 May 2019 11:26:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/2] fork: add clone6
Message-ID: <201905301122.88FD40B3@keescook>
References: <20190526102612.6970-1-christian@brauner.io>
 <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
 <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
 <CAG48ez2wyDhM-V1hs5ya1R4x7wHT=T8XLOYCPUyw97kzzLhbhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2wyDhM-V1hs5ya1R4x7wHT=T8XLOYCPUyw97kzzLhbhg@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 09:36:18PM +0200, Jann Horn wrote:
> +Kees
> 
> On Mon, May 27, 2019 at 9:27 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
> > > Hm, still pondering whether having one unsigned int argument passed
> > > through registers that captures all the flags from the old clone() would
> > > be a good idea.
> >
> > That sounds like a reasonable thing to do.
> >
> > Maybe we could continue to call the old flags CLONE_XYZ and continue
> > to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
> > flags for a new 64-bit flag field that comes in through memory in the
> > new clone_args thing?
> 
> With the current seccomp model, that would have the unfortunate effect
> of making it impossible to filter out new clone flags - which would
> likely mean that people who want to sandbox their code would not use
> the new clone() because they don't want their sandboxed code to be
> able to create time namespaces and whatever other new fancy things
> clone() might support in the future. This is why I convinced Christian
> to pass flags in registers for the first patch version.
> 
> The alternative I see would be to somehow extend seccomp to support
> argument structures that are passed in memory - that would probably
> require quite a bit of new plumbing though, both in the kernel and in
> userspace code that configures seccomp filters.

FWIW, the only path forward on this that I've been able to see is to
normalize how syscalls read memory from userspace, and to basically
provide a cache (i.e. copy from userspace once) that will be examined by
both seccomp and later kernel functions. I have not been able to imagine
an API that wasn't a massive amount of work to implement, though. Maybe
it could be done only for a few kinds of arguments (file paths, certain
structures, etc) but I haven't made any progress on it.

-- 
Kees Cook
