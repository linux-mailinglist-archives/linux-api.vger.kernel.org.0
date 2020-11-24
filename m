Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B502C2D7A
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 17:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKXQxC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 11:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731531AbgKXQw7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 11:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606236779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnlezwJ45zg2Qnp2D52xY62jIWVyx2m5sDtaGOEZsmE=;
        b=DHWKaCBWwSSEcZdrOPF+aKecQ5QUSPJPZAz2eXmtuvAWDbVkMe3ncKQ6fBwUBLb1bjHbNZ
        J1Uu26EhmyirBwH8hOxv17lSimFzymCob8V47fxTLTurpK43QMF62aCiVTCDJULgKjqRYf
        FmvI+0c9AdRs0QQoQz+GJWslD2oJeTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-GQt14SafORukP-kwtuZrhA-1; Tue, 24 Nov 2020 11:52:56 -0500
X-MC-Unique: GQt14SafORukP-kwtuZrhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E361006C8D;
        Tue, 24 Nov 2020 16:52:54 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30D8060BE5;
        Tue, 24 Nov 2020 16:52:50 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124133719.GA30896@infradead.org>
        <87k0ua26gm.fsf@oldenburg2.str.redhat.com>
        <20201124164659.GB14094@infradead.org>
Date:   Tue, 24 Nov 2020 17:52:48 +0100
In-Reply-To: <20201124164659.GB14094@infradead.org> (Christoph Hellwig's
        message of "Tue, 24 Nov 2020 16:46:59 +0000")
Message-ID: <87y2iqzogv.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christoph Hellwig:

> On Tue, Nov 24, 2020 at 03:08:09PM +0100, Florian Weimer wrote:
>> Do you categorically reject the general advice, or specific instances as
>> well?
>
> All of the above.  Really, if people decided to use seccompt to return
> nonsensical error codes we should not work around that in new kernel
> ABIs.

Fair enough, I can work with that.  Thanks.

Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

