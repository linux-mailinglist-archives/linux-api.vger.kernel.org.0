Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44A4097F0
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhIMPyQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 11:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242288AbhIMPyH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 11:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631548371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3ULkNN3/XfJylBmZ/HItDZv9Uxt7R1OIeLedwQKthY=;
        b=FZfQ1oyD/b3hC6+lwxGn39v+0rIeulei50qYdJlz4s5269IwLvxqIDB3sQ7iY/EQKGSr68
        V1RSEPBIx0E625v6uDqmOsv2tUX9YWd2e48gFARzKLfhAl1ymeDYr3rca3FpOGeprvngux
        m1JUEl3FRC9NHpvtjCexr7z79P+ERxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-gMqss-F0MWCA1O6CT3YIWg-1; Mon, 13 Sep 2021 11:52:49 -0400
X-MC-Unique: gMqss-F0MWCA1O6CT3YIWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BE0C1006AA0;
        Mon, 13 Sep 2021 15:52:48 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D8A5C1D1;
        Mon, 13 Sep 2021 15:52:45 +0000 (UTC)
Date:   Mon, 13 Sep 2021 17:52:43 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@strace.io>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] io-wq: expose IO_WQ_ACCT_* enumeration items to UAPI
Message-ID: <20210913155243.GA23359@asgard.redhat.com>
References: <20210913104101.GA29616@asgard.redhat.com>
 <872209f5-d11c-1b80-6146-5646206e22cb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872209f5-d11c-1b80-6146-5646206e22cb@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 13, 2021 at 07:28:11AM -0600, Jens Axboe wrote:
> This is really the same thing as before, just the names have changed.
> What I suggested was keeping the enum in io_uring, then just adding
> 
> enum {
> 	IO_WQ_BOUND,
> 	IO_WQ_UNBOUND,
> };
> 
> to uapi header. The ACCT stuff is io-wq specific too, that kind of naming
> shouldn't be propagated to userspace.

My apologies, I've overlooked the fact that the proposed names
are different.  Updated and resent[1].

[1] https://lore.kernel.org/lkml/20210913154415.GA12890@asgard.redhat.com/

> A BUILD_BUG_ON() could be added for them being different, but honestly
> I don't think that's worth it.

