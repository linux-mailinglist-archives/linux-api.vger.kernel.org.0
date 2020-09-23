Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCA276276
	for <lists+linux-api@lfdr.de>; Wed, 23 Sep 2020 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIWUt5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Sep 2020 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUt5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Sep 2020 16:49:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45452C0613CE
        for <linux-api@vger.kernel.org>; Wed, 23 Sep 2020 13:49:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r19so382293pls.1
        for <linux-api@vger.kernel.org>; Wed, 23 Sep 2020 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vR/4IIWUNKe15foWwpTS+9b9UDo/Qa9Bzr4DnMS8/ac=;
        b=cvjPnC0ctMeBB9Bs+hCjmPTbXFlh28AtvRC9s1zm2hw5bXo4ZM3zQP6zMGV/EI6SFo
         ZCLDgL2ZjoUvZ0VvL5o3QAIC/+pFqbd6cKVOng6IcDOjV9fnoffLoUMEnL06XcnSYhD5
         +9ECmXqHcYULlG40Fvwx9JHw4WrGQFnblwk/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vR/4IIWUNKe15foWwpTS+9b9UDo/Qa9Bzr4DnMS8/ac=;
        b=nulUyFWwhn6yjuFWK2UWi0bSyTYkNsdPx2roN+PPrEvanWsbDqwO8CaaEoZ8i1ikEc
         QLhrX6HJIeXvhC7OMH7cIgMbm8DQ2XvZ1j8Hc3qA+qIjcSNGLw0tR6KaN8L1+Rti9ZVX
         zOkudfUPh979zJPAek23CiSy84oImh1RKgZSUsHHT/8jQ0KkX0n9Xp70ZoAbKMgj91By
         hcZR7IHqJSVm769g2HKPXqkVBJeqMmrdwHyEe0KtqPHEVc7GKQ+o2VO+d01lUsO1E+Uk
         Vr17qV3jdWcM2uEGRTn2g+HbIaldmaGNkaaMrQt2AuF1HiqIe+0WYyiPse86UcR5Uhaw
         2iAQ==
X-Gm-Message-State: AOAM532OR+13EZhsVdeqft8ppGa7mc9sR8YTSVaH/2S4OrzQ6jJ7rLRl
        rDa/LxYJPs624QM5ZMZRgwmMsw==
X-Google-Smtp-Source: ABdhPJzAZbjKC++0LwmLMQfeQPatEJ5NMT1jot2+hrKf5dZand6yk9QurwfKoHW0Dn2mkHpfk4pEKA==
X-Received: by 2002:a17:90b:3c3:: with SMTP id go3mr1124426pjb.64.1600894196835;
        Wed, 23 Sep 2020 13:49:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m20sm514433pfa.115.2020.09.23.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:49:55 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:49:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <202009231349.4A25EAF@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
 <202009221243.6BC5635E@keescook>
 <874kno6yct.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kno6yct.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 23, 2020 at 04:18:26PM -0400, Gabriel Krisman Bertazi wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> >> Convert TIF_SECCOMP into a generic TI flag for any syscall interception
> >> work being done by the kernel.  The actual type of work is exposed by a
> >> new flag field outside of thread_info.  This ensures that the
> >> syscall_intercept field is only accessed if struct seccomp has to be
> >> accessed already, such that it doesn't incur in a much higher cost to
> >> the seccomp path.
> >> 
> >> In order to avoid modifying every architecture at once, this patch has a
> >> transition mechanism, such that architectures that define TIF_SECCOMP
> >> continue to work by ignoring the syscall_intercept flag, as long as they
> >> don't support other syscall interception mechanisms like the future
> >> syscall user dispatch.  When migrating TIF_SECCOMP to
> >> TIF_SYSCALL_INTERCEPT, they should adopt the semantics of checking the
> >> syscall_intercept flag, like it is done in the common entry syscall
> >> code, or even better, migrate to the common syscall entry code.
> >
> > Can we "eat" all the other flags like ptrace, audit, etc, too? Doing
> > this only for seccomp seems strange.
> 
> Hi Kees, Thanks again for the review.
> 
> Yes, we can, and I'm happy to follow up with that as part of my TIF
> clean up work, but can we not block the current patchset to be merged
> waiting for that, as this already grew a lot from the original feature
> submission?

In that case, I'd say just add the new TIF flag. The consolidation can
come later.

-- 
Kees Cook
