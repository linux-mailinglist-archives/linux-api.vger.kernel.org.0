Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE4D279254
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIYUir (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgIYUif (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 16:38:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE46C0613CE
        for <linux-api@vger.kernel.org>; Fri, 25 Sep 2020 13:30:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so3539651pgl.10
        for <linux-api@vger.kernel.org>; Fri, 25 Sep 2020 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xalch59fDuEKl76YuuW9L6ISBYkH/TTx0Ff+RgikJxo=;
        b=hYaTNdNHJvLXhzfO+DdQhP+Y6AQFVGOXPqty1ToYGSxhw3Gg9u0qORgOjwXhmBR7X+
         3RBtz3lDH0PW6AmY/qY7MMzKY6CsGoSJzyEB+byHzQg5n948zglNKeCBqL+BXCy6ISuz
         pLQE8ykuQBc1+Zol1mYktHi8NsaELoQn/dyBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xalch59fDuEKl76YuuW9L6ISBYkH/TTx0Ff+RgikJxo=;
        b=RkmBk/9l4fP5EWsccc5/l2oPWMibLp7PWSesoh/S4JGZ00V2/LU9CHaNdAmKi2zN6q
         c5/SVli2kT9Sy/BijOswhLVM4rIk6s3et+1LXmsJSDIWOEteduUgfbDlKplrp5BZ911Z
         VomQXYEtJ5lvDn+KRW/ir/6j8zcJ9/UPZ4XuqxPP2jX1w94fUub8TJd/ojYUC7RuytDy
         pNDU2tbQ5GZfGdvkxKfyiXr4g/gobXJuhYLump6tIwRQJOn9kvHdhCaw9F5v+FjeLySj
         DyXBy5rlZfwJXX7T1X3xDftICrcFfVaILGEarr5vyrQ2Dwbuh0z23dYY+RsIK4kbtCWS
         7ZEg==
X-Gm-Message-State: AOAM530N7SfsyCtGt0J2KCDoMErvyOABDOESL8L72EGrp3AF6359figU
        AVdvgfS5c9b++XxcqN7GEgaD7g==
X-Google-Smtp-Source: ABdhPJzmfj4AEPYzK8yIYg6dWta0UdlI0MvUEx+twtC6hiM5Se1DgdD+x9UOcYpIEItGRJ46ESH7fA==
X-Received: by 2002:a17:902:c252:b029:d2:4345:5c7 with SMTP id 18-20020a170902c252b02900d2434505c7mr1152244plg.4.1601065859302;
        Fri, 25 Sep 2020 13:30:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g1sm70849pjs.30.2020.09.25.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:30:58 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:30:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, luto@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <202009251327.587D111@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
 <202009221243.6BC5635E@keescook>
 <874kno6yct.fsf@collabora.com>
 <202009231349.4A25EAF@keescook>
 <87o8luuvze.fsf@nanos.tec.linutronix.de>
 <87k0whsuh1.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0whsuh1.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 25, 2020 at 12:15:54PM -0400, Gabriel Krisman Bertazi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Wed, Sep 23 2020 at 13:49, Kees Cook wrote:
> >> On Wed, Sep 23, 2020 at 04:18:26PM -0400, Gabriel Krisman Bertazi wrote:
> >>> Kees Cook <keescook@chromium.org> writes:
> >>> Yes, we can, and I'm happy to follow up with that as part of my TIF
> >>> clean up work, but can we not block the current patchset to be merged
> >>> waiting for that, as this already grew a lot from the original feature
> >>> submission?
> >>
> >> In that case, I'd say just add the new TIF flag. The consolidation can
> >> come later.
> >
> > No. This is exactly the wrong order. Cleanup and consolidation have
> > precedence over features. I'm tired of 'we'll do that later' songs,
> > simply because in the very end I'm going to be the idiot who mops up the
> > resulting mess.
> >
> 
> No problem.  I will follow up with a patchset consolidating those flags
> into this syscall_intercept interface I proposed.  I assume there is no
> immediate concerns with the consolidation approach itself.

I think the only issue is just finding a clean way to set/unset the
flags safely/quickly (a lock seems too heavy to me).

Should thread_info hold an entire u32 for all intercept flags (then the
TIF_WORK tests is just a zero-test of the intercept u32 word)? Or should
there be a TIF_INTERCEPT and a totally separate u32 (e.g. in
task_struct) indicating which intercepts? (And if they're separate, how
do we atomically set/unset)

i.e.:

atomic_start
	toggle a per-intercept bit
	set TIF_INTERCEPT = !!(intercept word)
atomic_end

-- 
Kees Cook
