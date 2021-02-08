Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61D313DA7
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 19:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhBHSgd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 13:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhBHSeb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 13:34:31 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB62C06178A
        for <linux-api@vger.kernel.org>; Mon,  8 Feb 2021 10:33:51 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so11055560qtw.4
        for <linux-api@vger.kernel.org>; Mon, 08 Feb 2021 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zsGQUeCVE+9P7aNp54v7uYNj84EfUFjIYL1mjfYFnhM=;
        b=FVZOhOlO1m/ZSXYxWqQ3/Ohq3Wp/tvRDC8GTvP+9bSnDEiozixF3Jhu580CVCPRbPm
         HJk4/2MMunffgKDn9bqK046yfyDvCxzIoA7T9EVtyNZfNB349GjItsMZSxgoMAhgi9KK
         nGadbvWT0KrcPvYiuq0YMFcdBLGx2QWttauttC9CmU/yQLFXG/FJzLeOF3qlZ6ifMM/6
         cG0R8kzOetckivQvI1vkoOdcGpp0+q8eD+xtEdsggBY1OP0qQ8kRpli+JjTQL4jj+cJE
         pYd3v7VG89h1Pnv0+WhajdC+jmuARDnJ7f5CKBccsE/96SEKVSqegmKaKZUt1ONCwfOI
         3mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zsGQUeCVE+9P7aNp54v7uYNj84EfUFjIYL1mjfYFnhM=;
        b=DlJ1mciLU6GIzxBaAsJTzDzqqlPdf0PCOgaJ+bcP2e/VHGPNwzZkiWAK6mTBUuk/Ni
         6WtqTWzhhjoKCoBjh0aaDp6AVKHsYiA25U169ZS+SmbYFq2OyeqX02uGDAZ2DmMyORm5
         yQlkj63nei9oMFPbBxMA0JC/pwHptnnK25zOPg8oFmm4ineHzQY4eTkqisYKY8+FAQjz
         O3EJN0AkXwyJ9u/pXofoVD4cFQb5cQIJPkm+10bFxg0hJzT9941Dd/+i60V1Hobpnmey
         hdN0U2bBBjRs6EHLnI0al7qg2GYMcnfUn5YXKKTdxS8HCMGXwykFgxapmTAwmFTHpjd7
         X0Pg==
X-Gm-Message-State: AOAM531pI+PdHPN0+vhQB46lJ4wiVpBMJgZIvP0pZAFq+P5dhmJtzGZb
        b5KQOy/NXOb4mTy5mw3Pb26FQA==
X-Google-Smtp-Source: ABdhPJw9LB1ZweabsqrMBku5FA6d/KFYbPv37y2NqRoUt6oYBe0PrhVhU9GHDLJJPMyumQU59KaDBQ==
X-Received: by 2002:aed:38e3:: with SMTP id k90mr16286292qte.119.1612809230040;
        Mon, 08 Feb 2021 10:33:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p18sm16809839qkj.130.2021.02.08.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:33:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9BM4-005254-G1; Mon, 08 Feb 2021 14:33:48 -0400
Date:   Mon, 8 Feb 2021 14:33:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        gregkh@linuxfoundation.org, song.bao.hua@hisilicon.com,
        kevin.tian@intel.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, liguozhu@hisilicon.com,
        zhangfei.gao@linaro.org, Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210208183348.GV4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 08, 2021 at 09:14:28AM +0100, David Hildenbrand wrote:

> People are constantly struggling with the effects of long term pinnings
> under user space control, like we already have with vfio and RDMA.
> 
> And here we are, adding yet another, easier way to mess with core MM in the
> same way. This feels like a step backwards to me.

Yes, this seems like a very poor candidate to be a system call in this
format. Much too narrow, poorly specified, and possibly security
implications to allow any process whatsoever to pin memory.

I keep encouraging people to explore a standard shared SVA interface
that can cover all these topics (and no, uaccel is not that
interface), that seems much more natural.

I still haven't seen an explanation why DMA is so special here,
migration and so forth jitter the CPU too, environments that care
about jitter have to turn this stuff off.

Jason 
