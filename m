Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF8F3591
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 18:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfKGRSG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 12:18:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54580 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728847AbfKGRSG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 12:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573147085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SEdWQaGFryuTv/nsU1+nEbvt9xnFrBLM9hi5OTh5uI=;
        b=QJy+YiWsRiyBVP5Oyk1auOE3Cl8/tpohPz7BG3aYRJmZhS42HVatC5aIPrR1F4yyYxZr7C
        OZCCPrV40g/JGvKyNXyCpZH2Ju+yhtfEPYcUI7yCVRICdIvUhgOvHMuVO78OkKvcmQbjmt
        Ge6c0NPcrfa/KQm4cL1QvfnmfWXAuJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-cIIWMNoZMgeVRr0hN4Mq8A-1; Thu, 07 Nov 2019 12:16:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F06C1005500;
        Thu,  7 Nov 2019 17:16:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 597AB608B3;
        Thu,  7 Nov 2019 17:16:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk>
References: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk> <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/14] pipe: Add general notification queue support [ver #2]
MIME-Version: 1.0
Content-ID: <28292.1573146969.1@warthog.procyon.org.uk>
Date:   Thu, 07 Nov 2019 17:16:09 +0000
Message-ID: <28293.1573146969@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cIIWMNoZMgeVRr0hN4Mq8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sigh.  I forgot to build it with the new config options disabled.  I've fix=
ed
that up and pushed it to the git tree.

David

