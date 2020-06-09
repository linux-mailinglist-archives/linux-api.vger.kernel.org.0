Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5C1F4665
	for <lists+linux-api@lfdr.de>; Tue,  9 Jun 2020 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgFIShq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Jun 2020 14:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgFIShp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Jun 2020 14:37:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371DAC05BD1E
        for <linux-api@vger.kernel.org>; Tue,  9 Jun 2020 11:37:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so13065057lfe.11
        for <linux-api@vger.kernel.org>; Tue, 09 Jun 2020 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwHRiAPDtrkwECsv6SA7fU7H4zLVJKTcGFNk2QXOnhU=;
        b=VIHY8xLiHmbfAk+929GtvjqxvUF90uuWGK5L3c+gPpqDFRUpDiapReEG17Y3LutSww
         3V4dWOmewogkwd+Eh2mmUpKoH16NlRQle+kI7Ko4/1uBuemv435R5GU4c4mZfT3By+vr
         SVqe2G5aySIYKw5hxgQiZjXAPzP+T8vokiag6aXGMR6sDZe5pPUDOq6HgWNca8MC52A7
         s5P1ye0S5PDBu7AxhHFPbfcEVraz8m2ymqGLFoxZrFnyou69s91LmCHH95LIuM1OqCgh
         uMYv3citOqdRrf9huGay2dU3OYM+dmat6IejYUUbBgED5NkrInRwRjh2cXUyRAkBVYvk
         BSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwHRiAPDtrkwECsv6SA7fU7H4zLVJKTcGFNk2QXOnhU=;
        b=POsWq/f2Rac/X/lwCNMarAIPLDpXyC1+prfmV1Cqhu8LiFRiSzyDvC1DpeLksH9ArV
         rmH1fg5i5iZspIxq3jH49nVnFclY0RkraqEtk887ALGywNS2t9842EzJSV7fQqEyiTH5
         XSf19xNViA5UXABoDk5/PwZResdeAaUoNtlHmzzEirHplVl5snn1RcSwoqsHEXDvz2ea
         Zuc2IHq18GRoXnp/UxU+s/A4j6pEIl1mfGtKGSJLCrxkz+W5mjjP60ypFTfaTNdQrvgI
         eAC50xoUSrQi8KQHkXGMZqGhlGA6bLWz1I5Zci0KzxrduLuDeryPe1BebTpiDbr5Eg1d
         eGLw==
X-Gm-Message-State: AOAM533qQXioFzsztpfFE37qcdSPJHxy8mGpS6WehfuQ9w1ADq4/macP
        sQZI5WI8wbGJN3Jgwo8fIvv9vpLqmPdrUibJGc5hOQ==
X-Google-Smtp-Source: ABdhPJxuVElaiZy/wi7zPSnZaETNDw3REFYZMvBDEZDwQF9KjdWC3LmrzfRnNv5y4/4dmn7H2To75+SN/JnbU9vOoOw=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr16495368lfc.142.1591727862693;
 Tue, 09 Jun 2020 11:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200601194822.30252-1-nigupta@nvidia.com>
In-Reply-To: <20200601194822.30252-1-nigupta@nvidia.com>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Date:   Tue, 9 Jun 2020 11:37:31 -0700
Message-ID: <CAB6CXpAGTWGNboAXEkqC2wZsHmvbhFf_5enguXJ7QssRpr=c9A@mail.gmail.com>
Subject: Re: [PATCH v6] mm: Proactive compaction
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 1, 2020 at 12:48 PM Nitin Gupta <nigupta@nvidia.com> wrote:
>
> For some applications, we need to allocate almost all memory as
> hugepages. However, on a running system, higher-order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages, but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) show that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.
>

> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

(+CC Khalid)

Can this be pipelined for upstream inclusion now? Sorry, I'm a bit
rusty on upstream flow these days.

Thanks,
Nitin
