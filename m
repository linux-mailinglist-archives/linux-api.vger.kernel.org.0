Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829A945C8C4
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 16:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhKXPhU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 10:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbhKXPhU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 10:37:20 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B6C06173E
        for <linux-api@vger.kernel.org>; Wed, 24 Nov 2021 07:34:10 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id v2so2005253qve.11
        for <linux-api@vger.kernel.org>; Wed, 24 Nov 2021 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jewS1/U+Uwx2MsMSvVTsbDbxDhtWEO2xK/fTTXK8uck=;
        b=WzvFRKZ061/KNaexoESH+Gbb4RgMMBXdqHhbtVDCJUWaGKS0bnX4c6P4VO4hkjahGS
         /3zHBhDb+rJ4bQfUU/5o0p7g5Oq4oHvasOY5UeFTNeegJ14CkGmQ0rO3rB12VPpaJpFR
         gChu8p5mtj04YG1x5v/Js2Wxkzh4Wbj7B3fohbz2UoOYCEyU/TDOBZLuXavFMULGkfTJ
         GjZzuFZNy3a1tQgtuifVOgbMoqA9TPXpZeM+Et1sowb/lyMJrVJ9CxBCNCSSNl79GP0A
         zTttDgOQkS2aqHt73ydZLqX6ZPRNdxo6YgMiQtSBwlqc06vXom0vpQ6CnRifIvQ6aw7l
         EeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jewS1/U+Uwx2MsMSvVTsbDbxDhtWEO2xK/fTTXK8uck=;
        b=RJM5/TFktsVrB7rNs4rCL35j3sWoabo9Diev5FQr1wWgi0wS9PdQxjWeDe3EEvzFIr
         ziCpNs7t2tPx5hsi9Dqzrr1Vo7QHxJOjsVQ5vQtCfJGfuEr4bQORtiu/+APaOyOax51B
         5N0iLEh2vtdmbrBbZjTQxFD6C9GxLq85Hlafs2ibxfyC/nb/7qWXQvRKNY7LW4ANaW3g
         0YO5uwB6CSoIzksqmU+rBwPPFbalrYGigGlywzQyP8eBGOlgy92okGulKmJIR0AM9qYw
         lXN7W7p5mso6j1oaWk92YH3mUjfUNLjblpRoW0Rn6uV3YIEcPBkkRSNjGFGRodWfAnbU
         f77w==
X-Gm-Message-State: AOAM530cidb9sd7rgP1w9iyNSHm6tdrVaVImaOcSAj5NCAMHeMEl33+O
        b0XATZl3S7MZ7SV9RA32zSSH8iC+TzFjDg==
X-Google-Smtp-Source: ABdhPJxZDhSiT7D5AMdmLtkaSczYkt5IgUp2uFeWHEYmNkWlb9JcYltzAKN/FqypiDM3IlbZxasu5A==
X-Received: by 2002:ad4:5dea:: with SMTP id jn10mr8349179qvb.17.1637768049952;
        Wed, 24 Nov 2021 07:34:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l22sm42040qtj.68.2021.11.24.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:34:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mpuHd-0013L9-Or; Wed, 24 Nov 2021 11:34:05 -0400
Date:   Wed, 24 Nov 2021 11:34:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
Message-ID: <20211124153405.GJ5112@ziepe.ca>
References: <20211123170056.GC5112@ziepe.ca>
 <dd92a69a-6d09-93a1-4f50-5020f5cc59d0@suse.cz>
 <20211123235953.GF5112@ziepe.ca>
 <2adca04f-92e1-5f99-6094-5fac66a22a77@redhat.com>
 <20211124132353.GG5112@ziepe.ca>
 <cca0229e-e53e-bceb-e215-327b6401f256@redhat.com>
 <20211124132842.GH5112@ziepe.ca>
 <eab5aeba-e064-9f3e-fbc3-f73cd299de83@redhat.com>
 <20211124134812.GI5112@ziepe.ca>
 <2cdbebb9-4c57-7839-71ab-166cae168c74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cdbebb9-4c57-7839-71ab-166cae168c74@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 24, 2021 at 03:14:00PM +0100, David Hildenbrand wrote:

> I'm not aware of any where you can fragment 50% of all pageblocks in the
> system as an unprivileged user essentially consuming almost no memory
> and essentially staying inside well-defined memlock limits. But sure if
> there are "many" people will be able to come up with at least one
> comparable thing. I'll be happy to learn.

If the concern is that THP's can be DOS'd then any avenue that renders
the system out of THPs is a DOS attack vector. Including all the
normal workloads that people run and already complain that THPs get
exhausted.

A hostile userspace can only quicken this process.

> My position that FOLL_LONGTERM for unprivileged users is a strong no-go
> stands as it is.

As this basically excludes long standing pre-existing things like
RDMA, XDP, io_uring, and more I don't think this can be the general
answer for mm, sorry.

Sure, lets stop now since I don't think we can agree.

Jason
