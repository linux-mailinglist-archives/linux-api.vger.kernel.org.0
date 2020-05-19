Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D381D8FA7
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 07:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgESFy4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 01:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgESFyz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 01:54:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32A2C061A0C;
        Mon, 18 May 2020 22:54:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l73so806556pjb.1;
        Mon, 18 May 2020 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KuFInB8SBsyIcapayRGL/wNNAtWfcntO3NhtMrJkPpc=;
        b=LV2rmPEX65G1P7yzlYAJpyPVHpR3Q6N78jpGYIV6PUPBodcaaPIjSkKiJVeCDhdyRf
         yiU9LynQ1C5yWPhBJPfuDCmTJU4aDqVsIsu5Bx1ZS1q/j+VKY7+VZMOMeIsobgS0X+Lp
         IflTXleJ50QPaYwRzJjO0V9MkrNXDxpNxVeApgsvpN2UvXUAUOipX5ojyJ/XTkahsyjJ
         k/KjWaW7VTD4T3lWmpZXuVuqrJWHvXxThzyOFfu6T+Z16+HM6akCXJZRAtCpMy85EhAe
         LfUuqoycJqZpuT9WkNdQDD2E9DAE2WMfp1SYrA0ZIkqxevqNRTAcNSi4YqdYOoQTeb1s
         xe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KuFInB8SBsyIcapayRGL/wNNAtWfcntO3NhtMrJkPpc=;
        b=gzg+jlsfNG0YrGIG6aG/JVh/YqVUsXmWBXj9hq302AIjjz6WCk9sESwNsLnwYjegst
         4eGhf747vPuju9OkeT9D26AKnwwEWY6wf8914zCvXBtNaylLsKSrdqWpvYti9e+g9I4H
         b6F7Sb0odtZpRdJuIH9vwpG/25j0vjNu0Qzs0g25IKPyu7uS02I4+GtBaJMJ5uxmCq9u
         KvbIRt5HeYJXWYJ/YNfIR/UQ9970ZDAiGTAqcWirgvPQmFX1udLYXhSZWOfu6oopii9U
         Sy4i8BaxR9soUSgzzZfJ4s0ZjhFcB0iEdNMt3p5yDn/hy/voa1i+Ym2ZQpEQXW7SC330
         gQVA==
X-Gm-Message-State: AOAM531+w7nEKiq6U9ekOJ4vSUq78MJXcSsx4s0JEKCe7DpE1iqojDN9
        DEJ9xERir6/VzdR/dO+lKws=
X-Google-Smtp-Source: ABdhPJyEGeaN/cshC/J5XWS3NtbK18AkQlyDwbUaSxJgu0y+9hl01mxZmVNpaCpGOJ9XL5vy5APVQQ==
X-Received: by 2002:a17:902:5588:: with SMTP id g8mr20295084pli.321.1589867694934;
        Mon, 18 May 2020 22:54:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 127sm10553604pfw.72.2020.05.18.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 22:54:53 -0700 (PDT)
Date:   Mon, 18 May 2020 22:54:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sjpark@amazon.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] mm: use only pidfd for process_madvise syscall
Message-ID: <20200519055451.GA255907@google.com>
References: <20200516012055.126205-1-minchan@kernel.org>
 <CAJuCfpGbPUpWLDgwt5ZP4Uf8fp6ht_6eqUypMVYYh3btJdz_8Q@mail.gmail.com>
 <20200518211350.GA50295@google.com>
 <20200518160656.b9651ef7393db8e0614a1175@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518160656.b9651ef7393db8e0614a1175@linux-foundation.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrew,

On Mon, May 18, 2020 at 04:06:56PM -0700, Andrew Morton wrote:
> On Mon, 18 May 2020 14:13:50 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Andrew, I sent this patch without folding into previous syscall introducing
> > patches because it could be arguable. If you want to fold it into each
> > patchset(i.e., introdcuing process_madvise syscall and introducing
> > compat_syscall), let me know it. I will send partial diff to each
> > patchset.
> 
> It doesn't seem necessary - I believe we'll get a clean result if I
> squish all of these:
> 
> mm-support-vector-address-ranges-for-process_madvise-fix.patch
> mm-support-vector-address-ranges-for-process_madvise-fix-fix.patch
> mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix.patch
> mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix.patch
> mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix-fix.patch
> mm-use-only-pidfd-for-process_madvise-syscall.patch
> 
> into mm-support-vector-address-ranges-for-process_madvise.patch and
> make the appropriate changelog adjustments?
> 

If you want to fold them all, please use the description below for
mm-support-vector-address-ranges-for-process_madvise.patch.

Thanks.

============== &< ===================

Subject: [PATCH] mm: support vector address ranges for process_madvise

This patch changes process_madvise interface:
  a) support vector address ranges in a system call
  b) support the vector address ranges to local process as well as
     external process
  c) remove pid but keep only pidfd in argument - [1][2]
  d) change type of flags with unsgined int

Android app has thousands of vmas due to zygote so it's totally waste of
CPU and power if we should call the syscall one by one for each vma.
(With testing 2000-vma syscall vs 1-vector syscall, it showed 15%
performance improvement.  I think it would be bigger in real practice
because the testing ran very cache friendly environment).

Another potential use case for the vector range is to amortize the cost of
TLB shootdowns for multiple ranges when using MADV_DONTNEED; this could
benefit users like TCP receive zerocopy and malloc implementations.  In
future, we could find more usecases for other advises so let's make it
happens as API since we introduce a new syscall at this moment.  With
that, existing madvise(2) user could replace it with process_madvise(2)
with their own pid if they want to have batch address ranges support
feature.

So finally, the API is as follows,

      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
      		unsigned long vlen, int advice, unsigned int flags);

    DESCRIPTION
      The process_madvise() system call is used to give advice or directions
      to the kernel about the address ranges from external process as well as
      local process. It provides the advice to address ranges of process
      described by iovec and vlen. The goal of such advice is to improve system
      or application performance.

      The pidfd selects the process referred to by the PID file descriptor
      specified in pidfd. (See pidofd_open(2) for further information)

      The pointer iovec points to an array of iovec structures, defined in
      <sys/uio.h> as:

        struct iovec {
            void *iov_base;         /* starting address */
            size_t iov_len;         /* number of bytes to be advised */
        };

      The iovec describes address ranges beginning at address(iov_base)
      and with size length of bytes(iov_len).

      The vlen represents the number of elements in iovec.

      The advice is indicated in the advice argument, which is one of the
      following at this moment if the target process specified by pidfd is
      external.

        MADV_COLD
        MADV_PAGEOUT
        MADV_MERGEABLE
        MADV_UNMERGEABLE

      Permission to provide a hint to external process is governed by a
      ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).

      The process_madvise supports every advice madvise(2) has if target
      process is in same thread group with calling process so user could
      use process_madvise(2) to extend existing madvise(2) to support
      vector address ranges.

    RETURN VALUE
      On success, process_madvise() returns the number of bytes advised.
      This return value may be less than the total number of requested
      bytes, if an error occurred. The caller should check return value
      to determine whether a partial advice occurred.

[1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
[2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
