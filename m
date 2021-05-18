Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA08F388033
	for <lists+linux-api@lfdr.de>; Tue, 18 May 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351753AbhERTAm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 May 2021 15:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351722AbhERTA1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 May 2021 15:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621364349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnsitSUYNYIrkYp5/4jTUdGYLDO+k29G3HMJTBbuxHc=;
        b=EkEnPZYfXGZbIUMffMCD9bsD7U5YpOubZy3zVePHIlQ6iCalr0PY4tGF47JwYIfPsvzzMV
        aMIGXAX3ilbvk1sbFoJx3I2Nf9AZEz9cOc5EAkDnpuZTrDbWQt/EOmM0xpzvsviKzMD0BX
        4vsUpIDXF2iUccqHmu1OnlqRe8eRCtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-vS--UL1LNZqF1pGSTXmJPQ-1; Tue, 18 May 2021 14:59:04 -0400
X-MC-Unique: vS--UL1LNZqF1pGSTXmJPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDEE11012D9A;
        Tue, 18 May 2021 18:59:01 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2345B100F49F;
        Tue, 18 May 2021 18:59:01 +0000 (UTC)
Date:   Tue, 18 May 2021 12:58:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shenming Lu <lushenming@huawei.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-api@vger.kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
Subject: Re: [RFC PATCH v3 4/8] vfio/type1: Pre-map more pages than
 requested in the IOPF handling
Message-ID: <20210518125826.7ba38b78.alex.williamson@redhat.com>
In-Reply-To: <20210409034420.1799-5-lushenming@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
        <20210409034420.1799-5-lushenming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 9 Apr 2021 11:44:16 +0800
Shenming Lu <lushenming@huawei.com> wrote:

> To optimize for fewer page fault handlings, we can pre-map more pages
> than requested at once.
> 
> Note that IOPF_PREMAP_LEN is just an arbitrary value for now, which we
> could try further tuning.

I'd prefer that the series introduced full end-to-end functionality
before trying to improve performance.  The pre-map value seems
arbitrary here and as noted in the previous patch, the IOMMU API does
not guarantee unmaps of ranges smaller than the original mapping.  This
would need to map with single page granularity in order to guarantee
page granularity at the mmu notifier when the IOMMU supports
superpages.  Thanks,

Alex

