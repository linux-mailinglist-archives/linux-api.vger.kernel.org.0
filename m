Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC0F343B03
	for <lists+linux-api@lfdr.de>; Mon, 22 Mar 2021 08:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCVHzG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Mar 2021 03:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVHyd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Mar 2021 03:54:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911EC061574;
        Mon, 22 Mar 2021 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xrt2R+R/QcWWdbizw9P2yOnC4GYX4QH6HtSqRJOKuZM=; b=JlT9qfBWh/cDHYRV0U74X7AcQ/
        Fojxb2Cia/vWUn71j1RocbeEEJ3oulDvZRs/RVoGdNkXbNt5wN7VYRzV3hyrwj67DsVuT668nJJ3U
        DFNkCkq3aBU8+z7jxTzdkbrTIZGBa/0HUnBmzEEtn0+r9Uk7rw4fnQR5Zw2IHbq+2s7Ef1L9sYJiC
        UAKPTViaKDjbNJJqXJNY+eX2yuiu6jISQ+2eR8gQ65JBfwpf1WIbfV06R61bIl+eWQh6K7yumxJ+y
        wcqP38P68WQYQOl3wNcmJV/iZkpLl4ViVyZN0d3yp6JXtv/XbA+382zuwW+vyiA+M4tnAwyC2HX09
        Xk3xB1Ow==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFN8-008Ai8-D3; Mon, 22 Mar 2021 07:53:21 +0000
Date:   Mon, 22 Mar 2021 07:53:10 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] Document that PF_KTHREAD _is_ ABI
Message-ID: <20210322075310.GA1946905@infradead.org>
References: <YFYjOB1jpbqyNPAp@localhost.localdomain>
 <CALCETrUPAvUOr8V5db0gu5RKVftKFwbBEkh6Aob57v+D-xdEig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUPAvUOr8V5db0gu5RKVftKFwbBEkh6Aob57v+D-xdEig@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 20, 2021 at 10:23:12AM -0700, Andy Lutomirski wrote:
> > https://github.com/systemd/systemd/blob/main/src/basic/process-util.c#L354
> > src/basic/process-util.c:is_kernel_thread()
> 
> Eww.
> 
> Could we fix it differently and more permanently by modifying the proc
> code to display the values systemd expects?

Yes, do_task_stat needs a mapping from kernel flags to UABI flags.  And
we should already discard everything we think we can from the UABI
now, and only add the ones back that are required to not break
userspace.

