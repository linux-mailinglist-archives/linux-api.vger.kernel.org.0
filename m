Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995F928D2F3
	for <lists+linux-api@lfdr.de>; Tue, 13 Oct 2020 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgJMRQO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Oct 2020 13:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgJMRQO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Oct 2020 13:16:14 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201E225334;
        Tue, 13 Oct 2020 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602609373;
        bh=P88v3uczwmNVagw81qRi3rAiSPy869r419KvBCA3QZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mrno2bTWkgwsgxWy4DV4bYCRvfmUzGQ8vi9D5OzvcHSUPHEsUOT+eMpvUtHS+xI/z
         mFJsI0v0Mj8o8XD2iMXMER7s1lZpiCITsCQPOrKep1kmZnA7OI3O6d3Cf8V71Ot/7l
         /rhyZdTpER689Zedi00931GZLDx+y+7/9xegNkjg=
Date:   Tue, 13 Oct 2020 10:16:10 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de, linux-api@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 1/3] block: add zone specific block statuses
Message-ID: <20201013171610.GB1033288@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200924205330.4043232-1-kbusch@kernel.org>
 <20200924205330.4043232-2-kbusch@kernel.org>
 <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jens,

I'm going to try one more time in the hope you've just been too busy to
notice these patches. The series has been unchanged for a month now, and
has reviews from all the right people. Can this be considered for
inclusion?
