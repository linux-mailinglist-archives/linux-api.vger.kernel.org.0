Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8038D177
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 00:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEUW1y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhEUW1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 18:27:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1E3C061574
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 15:26:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s7so5584682iov.2
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XkWG9p3vuThMnzF5+jHBK0yD8kKyiYj1CsPVcIZG2k=;
        b=NbxYYDnKLkoxAba68BqL9ZpD3lb2ScBJAQcY7Ca85CXetGoTwjl6vkFeBlTcN0YXWC
         cakB/2NABQKb7tNbJ2MKqdWXSJWkXwDc/wdJ8H7ra+iLPE55/qTgRwSHMrd07MrYUY75
         Kgl+MdH4q6qoh3P/D/eA9hwhI9aygyHy6++nMr5XZJFn3YbAGBkxb+ubQgrwI1dJD3OY
         9vRWqUhp82BhFUfhdlge9Gw7weWCJYd2vfR0waS4FJhMBieNYCihC9+e4aQthIz0cPw7
         nPcq/dSyh3TQ2iYZM3164IV6Hk3xNVVeEtw/KweHzEb/39DcVr+NmfeTkJfTD0gaB7bH
         HDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XkWG9p3vuThMnzF5+jHBK0yD8kKyiYj1CsPVcIZG2k=;
        b=pmm3qHUOgP75anytzvfKtVTJumnmzFpJZPlqAdHoyMvnbVXxzTwLfiQFIHf6KlA0tV
         ox2Sg57msbvO8WzFeG1hSN+wkbEuf2TYPCRYYOmq+P5FgtA0HFiUlmj8IhgByCbYaPhf
         yI/uowofkYltmTmPhV9It4rTLYeJ0Rka0vePvwfJM6WqpSTjS4286g+OKCSCjJGZxaRk
         eUnZjsVPjBaCwPcLi+JYDSPDzR7JVHP7OUI6vYzH8q7v2uHMM3KTO/diL1Rrw0N9biuf
         yIZbq5UQiwwEhMjise9Ok8/WdOexXmYws3hsBrL7DdEV7CgM2VJsshCCTN8Zjz4XTjfF
         agxQ==
X-Gm-Message-State: AOAM5305ElcUEa5uEYnlo5gyfijayYmSOxYp8PeCYaqyIgEShTq5dfSv
        1GZJpckPlD+6yR2jb7LQh3XRkVbdSkuTOJO0+GxuMA==
X-Google-Smtp-Source: ABdhPJzlwY4snWFXpxBlNWlDJVr5O/yWYAqwfXJReVJK7U77qf3035eHhy3r6Qq2WuRy8RNFs9VDtvKPjIC+Z+H1LKQ=
X-Received: by 2002:a02:aa85:: with SMTP id u5mr7968024jai.75.1621635984233;
 Fri, 21 May 2021 15:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221211.29077-1-yu-cheng.yu@intel.com> <20210521221211.29077-14-yu-cheng.yu@intel.com>
In-Reply-To: <20210521221211.29077-14-yu-cheng.yu@intel.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 21 May 2021 15:25:47 -0700
Message-ID: <CAJHvVcjsecq-nOVE1ew1ctG2UpK0F0d0MjNncUgK0L=R4eyDqA@mail.gmail.com>
Subject: Re: [PATCH v27 13/31] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This seems reasonable to me. The particular bit used isn't so
important from my perspective. I can't think of a way this would break
backward compatibility or such. So:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Fri, May 21, 2021 at 3:13 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
> VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..923f89b9f1b5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -373,7 +373,7 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -# define VM_UFFD_MINOR_BIT     37
> +# define VM_UFFD_MINOR_BIT     38
>  # define VM_UFFD_MINOR         BIT(VM_UFFD_MINOR_BIT)  /* UFFD minor faults */
>  #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  # define VM_UFFD_MINOR         VM_NONE
> --
> 2.21.0
>
