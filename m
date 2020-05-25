Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270DB1E1123
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390956AbgEYO7J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388687AbgEYO7I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 10:59:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10308C061A0E
        for <linux-api@vger.kernel.org>; Mon, 25 May 2020 07:59:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so21092409ljc.8
        for <linux-api@vger.kernel.org>; Mon, 25 May 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEbHD2ev263wlFRheDig3n99CabBDelJzVN0Rki9PdU=;
        b=enNvc4+9hQuIOZOIh3CaF8Xu0UeS+b0QfIV6J5Y+QYtH841jSCEK08HAeRk1to7Ei7
         mo18xJOlr+wir0EjKge1Voe2Z6a3szF3i50Zj1DIcl2dF4cyHDBAuWKs8XmOR6BD2Uub
         xef+MqLgkQEgyiJJZTBGfCKGQ2yWMsPHDg7jY+wGy0r4JAaFtWLIcj/WUzNwBYtvtQ/i
         cSXFVtNNN3PNkIfjSzeLaHI1VJOTBNl0XV0sUEhY3nhCBi/s4KR4ZrlqL17n6HDZSLTU
         uaQBd1ajC9jkJiXhhkBc8BWDeRk12QnICMUmZf1+eu3v75Jxwzs5IWC2htaEpEslfgcM
         fVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEbHD2ev263wlFRheDig3n99CabBDelJzVN0Rki9PdU=;
        b=JgG4R5VtL3P2x8y5r/dD19LjIHoeaEAWo7lkqvzHkMaNDi+bRfJhXp0HCNhsYUE2T2
         x8YZHCYSG8kDBUd6IQTBbg12m4KUlaIGJ4cWp4KYxAffUDxjI9iTl3RqRhb6Zmu4mX2w
         K6YYAEqb95thTzFDCdblb3u2Nbda18Drn0Qn65l7hZHBxAzI93HkBjFJ6IIM+nD/Dr2B
         kSV8WpW8WB7itZ5j4+yM1ZbeeKSL0HjNXZNud3/2bcNrmU+FJ5+gLVgKTEMsu5fXqH25
         P94Y71QcIeiPD20RBY6mGkmUr9i7VG5bavl5cGgnzmZgVt2KdwY5hjgY3KNASVAnFrv3
         ze/g==
X-Gm-Message-State: AOAM532FDJ2tv9LcEhnXJqHWdu0c1AbFqIZ4aTXHl7mubjajXKQ+9FlG
        39t4NlkhZFAnjFrBkML2HFa7UQ==
X-Google-Smtp-Source: ABdhPJwRf7RFMRCGGPJo5Q4CtZh9c7tpy4gmdWyeTAE62C3TTupgb3dtVWxbju39YxVIt4HlovmXJg==
X-Received: by 2002:a2e:7619:: with SMTP id r25mr14688414ljc.42.1590418746399;
        Mon, 25 May 2020 07:59:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w6sm4697970ljw.89.2020.05.25.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:59:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DFB3F10230F; Mon, 25 May 2020 17:59:06 +0300 (+03)
Date:   Mon, 25 May 2020 17:59:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, Rik van Riel <riel@redhat.com>,
        linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-api@vger.kernel.org, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        Colm =?utf-8?Q?MacC=C3=A1rtaigh?= <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
Message-ID: <20200525145906.e5xfzmj6hvl7t4fg@box>
References: <20200521222551.259804-1-irogers@google.com>
 <CAP-5=fXjXgWEgp9gqReByrDBTvjDbPEsubeAFxrpxj_+FsFn6w@mail.gmail.com>
 <1edcb7ac-bc5f-b9ec-a037-656005ae85e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edcb7ac-bc5f-b9ec-a037-656005ae85e3@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 25, 2020 at 03:50:38PM +0200, Michael Kerrisk (man-pages) wrote:
> On 5/22/20 1:13 AM, Ian Rogers wrote:
> > On Thu, May 21, 2020 at 3:25 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> This patch documents a flag added in the following kernel commit:
> >>
> >> commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
> >> Author: Rik van Riel <riel@redhat.com>
> >> Date:   Wed Sep 6 16:25:15 2017 -0700
> >>
> >>     mm,fork: introduce MADV_WIPEONFORK
> >>
> >> This was already documented in man2/madvise.2 in the commit:
> >>
> >> commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
> >> Author: Rik van Riel <riel@redhat.com>
> >> Date:   Tue Sep 19 20:32:00 2017 +0200
> >>
> >>     madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> > 
> > Doing a quick audit of fs/proc/task_mmu.c having noticed this flag was
> > missing I note:
> >  - "mp" isn't documented, only possible with INTEL_MPX
> >  - "nl" is documented but not present in show_smap_vma_flags
> >  - "um" and "uw" aren't documented
> 
> I took a shot at fixing these:
> 
> 
>              mp  - MPX-specific VMA (x86, since Linux 3.19)

This one is gone. The patch to remove leftovers of MPX is linux-next.

-- 
 Kirill A. Shutemov
