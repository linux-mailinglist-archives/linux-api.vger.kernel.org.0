Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10C925B110
	for <lists+linux-api@lfdr.de>; Wed,  2 Sep 2020 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIBQOn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Sep 2020 12:14:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728436AbgIBQOj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Sep 2020 12:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599063278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gq3PYF0gH8Upn/AlKMBtYe87jdOYmG1nzMekq+7sJyM=;
        b=A/CxBvH+ODZOxyWkYUm5G+n2d+gJtEfKZan2O5M8Qgzf8a12Jce3Bq1XvFX5y0dFS4nQwN
        wzrPjpGaHlzCsOVNwiJu3PaQzJ6j8hUYPIb51GsQ9iUOAkdN0HV33TiQ+sP4F0+grn/Qer
        pZa4U64bfq8dnZBUQMCatjdy6ngCeL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-fljllp1xPEa5OhAcrU6DUg-1; Wed, 02 Sep 2020 12:14:34 -0400
X-MC-Unique: fljllp1xPEa5OhAcrU6DUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7ED71005504;
        Wed,  2 Sep 2020 16:14:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 880967E306;
        Wed,  2 Sep 2020 16:14:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com>
References: <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com> <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk> <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
To:     mtk.manpages@gmail.com
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <667615.1599063270.1@warthog.procyon.org.uk>
Date:   Wed, 02 Sep 2020 17:14:30 +0100
Message-ID: <667616.1599063270@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> The term "filesystem configuration context" is introduced, but never
> really explained. I think it would be very helpful to have a sentence
> or three that explains this concept at the start of the page.

Does that need a .7 manpage?

David

