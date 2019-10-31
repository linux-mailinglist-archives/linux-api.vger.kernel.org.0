Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C90EB3A6
	for <lists+linux-api@lfdr.de>; Thu, 31 Oct 2019 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfJaPN1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 31 Oct 2019 11:13:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727707AbfJaPN1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 31 Oct 2019 11:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572534805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNwFRZjnDpMMCUFzfJOSVzkAkD/c1c7Ojt9o9rhUq2Y=;
        b=eTisoTQLr5iStvNrpLpqaYPe2y5YzdvVpdoNVUAZHcB8GQw7qHmMzdGmj1/Nnd+8Brlg6r
        bgDhkeGG+3GXa5bjzRAAVCR2c4R7LEmlYvxg+8A7MS+N8lYR7AdVUC/NDCUhc2B0CVEIJR
        /A9fUlEWbOIn/+fkFgiOC2vQbxYp1vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-jD0V8FpeNOqkFxE4eETZKg-1; Thu, 31 Oct 2019 11:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 839B11800D6B;
        Thu, 31 Oct 2019 15:13:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97A915DA7D;
        Thu, 31 Oct 2019 15:13:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191027152223.GA21194@infradead.org>
References: <20191027152223.GA21194@infradead.org> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <30394.1571936252@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
MIME-Version: 1.0
Content-ID: <17041.1572534796.1@warthog.procyon.org.uk>
Date:   Thu, 31 Oct 2019 15:13:16 +0000
Message-ID: <17042.1572534796@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: jD0V8FpeNOqkFxE4eETZKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> I am _really_ worried about overloading fsync for this behavior.  fsync
> hasn't done anything for 50 years, and suddenly adding any action
> is not helpful.  If you can't use FIONREAD please add a new ioctls
> instead, and document it properly.

Okay.

David

