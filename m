Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0877345B087
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbhKXADG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Nov 2021 19:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbhKXADE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Nov 2021 19:03:04 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D136C061714
        for <linux-api@vger.kernel.org>; Tue, 23 Nov 2021 15:59:56 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a2so924081qtx.11
        for <linux-api@vger.kernel.org>; Tue, 23 Nov 2021 15:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWwXPG24ltmWOflqT79hbe7WHAGSXzFDRpPzyqTCphM=;
        b=SM7g2CC2T7HtEJAOomAVVeoee9cBvpCmPhxJgr3oGO8VH5HDRMkKwuNnBdd/tdtLra
         ix57VCmhP/D7B7OeCzH8s3rrnpADi75OMdOMFwELa15V0MBJDAvel4bfDue625PHX6OG
         hS6h6+fJuNRKIYJkla2s/iTwTYPHWRYYa0/1VdGXSQPkR5SOAWvSE54rNRYV4UTL/pyB
         YKJ7Wzj0llu879N5OsWvxcLn+Em+r+KowY4iabzniDrrl1UmaTxLZD4jvwTpO97ItqwK
         HI8tPMYfGiMInv0fc7x84iaO3eiMci7X4scAZRwoS8d5ff2O7cTzDrXSvh/sNXeg6f9H
         8O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWwXPG24ltmWOflqT79hbe7WHAGSXzFDRpPzyqTCphM=;
        b=Hfds917QtzFy1SESDqQE3uKlxjagHlJXT4I8Zi27mriz0E6z9av+lQFeUs4Okp9mkn
         F9fy8iFTD+3sBVXbgY9jEggp3CjGSkT09Ol1K5c7d0WF5p5zoOTDPcM6pjvBtA88Z3c4
         qdHpMnYvnkQ0Y6aQxvGTmnA+JGrv6TXlNXoa7ah1aSD9E1LBYygLPA/BrLriFBOnTXpW
         +G+7SBrv7mM+TCuylw7+3EvvanQ8SQ2QZWaxLljsPGsmV3urnSdfOjpcsOcrvGKnpbcN
         kfGoyFTpLWoHJ7aSv0RUu2JuaDnfJ1YaCjqjqEMiO2Al/wwYjFpZ5ZHXFsyVoE8JYJqj
         +Nog==
X-Gm-Message-State: AOAM531N1p+dVH0w9jHjZjSFqkutp8+edI+ewySn8YYyFKp2zx995ihj
        h9zvUpQy25JM2qFE/i405TQwlQ==
X-Google-Smtp-Source: ABdhPJxUUgxbyWZyuW6Sl74vLoLYpS/heqCJSK/6Ktu0i9Jt6ejBXXhBIGBoXvKcqrkbxigSQu4NJg==
X-Received: by 2002:a05:622a:1901:: with SMTP id w1mr1756372qtc.134.1637711995285;
        Tue, 23 Nov 2021 15:59:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f16sm6699243qkk.16.2021.11.23.15.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 15:59:54 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mpfhZ-000naV-I3; Tue, 23 Nov 2021 19:59:53 -0400
Date:   Tue, 23 Nov 2021 19:59:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
Message-ID: <20211123235953.GF5112@ziepe.ca>
References: <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
 <20211123132523.GA5112@ziepe.ca>
 <10ccf01b-f13a-d626-beba-cbee70770cf1@redhat.com>
 <20211123140709.GB5112@ziepe.ca>
 <e4d7d211-5d62-df89-8f94-e49385286f1f@redhat.com>
 <20211123170056.GC5112@ziepe.ca>
 <dd92a69a-6d09-93a1-4f50-5020f5cc59d0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd92a69a-6d09-93a1-4f50-5020f5cc59d0@suse.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 23, 2021 at 11:04:04PM +0100, Vlastimil Babka wrote:
> On 11/23/21 18:00, Jason Gunthorpe wrote:
> > 
> >> believe what you say and I trust your experience :) So could as well be
> >> that on such a "special" (or not so special) systems there should be a
> >> way to restrict it to privileged users only.
> > 
> > At this point RDMA is about as "special" as people running large
> > ZONE_MOVABLE systems, and the two are going to start colliding
> > heavily. The RDMA VFIO migration driver should be merged soon which
> > makes VMs using this stuff finally practical.
> 
> How does that work, I see the word migration, so does it cause pages to

Sorry I mean what is often called "VM live migration". Typically that
cannot be done if a PCI device is assigned to the VM as suspending and
the migrating a PCI device to another server is complicated. With
forthcoming hardware mlx5 can do this and thus the entire RDMA stack
becomes practically usable and performant within a VM.

> be migrated out of ZONE_MOVABLE before they are pinned?

GUP already does this automatically for FOLL_LONGTERM.

> Similarly for io-uring we could be migrating pages to be pinned so that
> the end up consolidated close together, and prevent pathologic
> situations like in David's reproducer. 

It is an interesting idea to have GUP do some kind of THP preserving
migration.

Jason
