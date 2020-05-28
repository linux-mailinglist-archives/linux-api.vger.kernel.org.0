Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7E1E68C2
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405594AbgE1RjM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405581AbgE1RjL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 May 2020 13:39:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C7C08C5C7
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 10:39:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so1596284ljo.0
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GSyn/GzlUuBVZreRe5FoudqPDQtAy00iQYfXxKL+O/Q=;
        b=AMSzGREpSnoqwtwv9pZaGx8ez0dlArn60F3wpoUwlsaAoeLWH+YHNw44SgBlBc7vag
         nn2sp9vyKpRzVPN2on4hlPXML8hzV9g2MyHMr3GY249VZJRGGaUIZ5yc10CadFZiTtzk
         vcuNxha92NhynzKiT0b3k8qSRW7e8dp7oNXB84i2wREsncxeDD9rVNkm2JqJALwopBVm
         S+YRP+Hb5qUqPmxTTMYrYWWTXXwJKyQATZ+qjgYUdJ/8fG61hiGWvtHweD/MIWMX0a2a
         y8r66OlLZHSCB4BwPYW16zxiL2qM9iDqfxCMWJfACPLhLqsM2icegfAyoFt0HgTWVS4Q
         vlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GSyn/GzlUuBVZreRe5FoudqPDQtAy00iQYfXxKL+O/Q=;
        b=FxbpVHAyh+iN5wJFYIwEU2avaW4bbCtQ/9pZTiVp0IUm7+9MxrM6Lr/+O9sDakgy2Z
         J1jnmqo3C7747PRL0pXXjzrvcDhG9MKJ1hrsiYudGGvHcz7VV8RT2ZkNb322BqD3WOTy
         aj8wFSqji6PpgtjBjK8cS/v8c6WUOA19h1g507fNndBotgHleLMzpmbUeGtigeoO9ysa
         8+0dmcIZWxZhlB7ndE61IfWAXvQhh1TULoMC8yD7UFLLUxLlvDdVQEDq4d0Fyll4hdKj
         3Gdh+4WGzW2B7IHzhV30LynP2SHOLJ+51+TAZ4M3tkqkIFtkWvSi+sNDiKIQWSuCHGMF
         HwFg==
X-Gm-Message-State: AOAM531VQqbfECHaJILrOrVh44E5n1QxUzsobEj6C5l8BlSI4beyCjvm
        rGqX1vKPOys0K+XWzDjW6xJ9Rw+35p/SbXjyWVmslhxSpTSJ7A==
X-Google-Smtp-Source: ABdhPJztXzq3yXMj4FT3uUbqkiTJL24i9SV+yD18Z6q5cM2dbT2DdkdzT9A9pFh+q0gqZ0uWQC5J3lj/V1fV3PrxgyM=
X-Received: by 2002:a2e:9099:: with SMTP id l25mr2082879ljg.82.1590687549294;
 Thu, 28 May 2020 10:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200518181446.25759-1-nigupta@nvidia.com> <27b39956-2a21-8eef-8ebb-cb3a93a41a36@applied-asynchrony.com>
 <ab3e4c38-a7f9-01fc-f25f-f13f8e30985f@suse.cz>
In-Reply-To: <ab3e4c38-a7f9-01fc-f25f-f13f8e30985f@suse.cz>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Date:   Thu, 28 May 2020 10:38:57 -0700
Message-ID: <CAB6CXpCpr=rmokWS14tTvgkYaiFac-QKPg8xXFbKYn1uD5k0pg@mail.gmail.com>
Subject: Re: [PATCH v5] mm: Proactive compaction
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 28, 2020 at 2:50 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 5/28/20 11:15 AM, Holger Hoffst=C3=A4tte wrote:
> >
> > On 5/18/20 8:14 PM, Nitin Gupta wrote:
> > [patch v5 :)]
> >
> > I've been successfully using this in my tree and it works great, but a =
friend
> > who also uses my tree just found a bug (actually an improvement ;) due =
to the
> > change from HUGETLB_PAGE_ORDER to HPAGE_PMD_ORDER in v5.
> >
> > When building with CONFIG_TRANSPARENT_HUGEPAGE=3Dn (for some reason it =
was off)
> > HPAGE_PMD_SHIFT expands to BUILD_BUG() and compilation fails like this:
>
> Oops, I forgot about this. Still I believe HPAGE_PMD_ORDER is the best ch=
oice as
> long as THP's are enabled. I guess fallback to HUGETLB_PAGE_ORDER would b=
e
> possible if THPS are not enabled, but AFAICS some architectures don't def=
ine
> that. Such architectures perhaps won't benefit from proactive compaction =
anyway?
>

I am not sure about such architectures but in such cases, we would end
up calculating
"fragmentation score" based on a page size which does not match the
architecture's
view of the "default hugepage size" which is not a terrible thing in
itself as compaction
can still be done in the background, after all.

Since we always need a target order to calculate the fragmentation score, h=
ow
about this fallack scheme:

HPAGE_PMD_ORDER -> HUGETLB_PAGE_ORDER -> PMD_ORDER

Thanks,
Nitin
