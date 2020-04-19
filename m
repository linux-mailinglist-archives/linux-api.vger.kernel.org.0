Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732CB1AFE4C
	for <lists+linux-api@lfdr.de>; Sun, 19 Apr 2020 23:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSVJW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Apr 2020 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725891AbgDSVJW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 19 Apr 2020 17:09:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34339C061A0C
        for <linux-api@vger.kernel.org>; Sun, 19 Apr 2020 14:09:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so1717029lja.13
        for <linux-api@vger.kernel.org>; Sun, 19 Apr 2020 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JGN7wLVHXwvgXkhYgDE5pBGoB6Yj1cQ4trKcrvGh/o=;
        b=Tad6GT9AGCZSv2/7xBX5bjyZ5esROH/JcXlUtWQU+uUcgJtcCdw3yPJzlj7dZb5K7F
         mEO0if045eF3URAWdqTUUsLbriq/4/p58gEuhzAa8o341ht0/ri3x0YCUzwX5hCMMQyu
         7MJ5QPZiankwcVyg8JFPeMxhI9PZwurPZ4Jmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JGN7wLVHXwvgXkhYgDE5pBGoB6Yj1cQ4trKcrvGh/o=;
        b=W7C29zWV+Ysg0NfAM0xvF0OfymiaTEJct25hfgspZe6Ol+2cOvgYAlGrpjeo2Eka9x
         pxU1GfzgBUyqxoM6X+9fOEJAXbxmYBatF90N4SQF8kvdxHXTHqJ2xBVRYF79oxC/JTQ3
         p6wtP+TIyC0fPuisUbzNEORSzeuccNItZ2uvabDHJFQNf04KHCCuxoQxy7dgOcK85sKT
         IGIjPz+VvVjEWBdJfalfR/btKeyfs/Sfy2vILHyTQtD8Y+asMwMWu2aN/lQ+bnwYl3X2
         F4SrDJqasnbgERMk1CF3l4wBCQl/SlSxm23zUznaPp3KHPnP7VXaG81W6hcDXW9kvhgK
         TkxA==
X-Gm-Message-State: AGi0PuaxSyjTdm/HsXWujIxYvyWDKcMWA32dshtXN7i/L0ohzPDTLqzD
        3CvgGMxLji7I3r83JjbMVfTozcLXKi4=
X-Google-Smtp-Source: APiQypLpnrOo3TDOSl0cMvR70fMVKg1kEC4WpjqGrQYIo2Yt9MFIZKCChUiiCYt3tXeJkJN1oZcPqA==
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr7585239ljc.209.1587330560137;
        Sun, 19 Apr 2020 14:09:20 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t19sm23792028lfl.53.2020.04.19.14.09.19
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 14:09:19 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id l11so6249018lfc.5
        for <linux-api@vger.kernel.org>; Sun, 19 Apr 2020 14:09:19 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr8190138lfk.192.1587330558759;
 Sun, 19 Apr 2020 14:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200417172556.217480-1-bgeffon@google.com> <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
In-Reply-To: <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Apr 2020 14:09:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxnvTK-n8fwNJVHB95-9whnPXZ8jJ7xDOT-dxi5biwxQ@mail.gmail.com>
Message-ID: <CAHk-=wjxnvTK-n8fwNJVHB95-9whnPXZ8jJ7xDOT-dxi5biwxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix MREMAP_DONTUNMAP accounting on VMA merge
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Sonny Rao <sonnyrao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Apr 19, 2020 at 10:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I do have a query: would it perhaps not be a good idea to simply
> remove the "vma_merge()" call from copy_vma(), and do at the end of
> move_vma() instead?

I decided to apply the patch regardless, even if somebody does end up
deciding "yeah, let's move the vma_merge() down" later.

             Linus
