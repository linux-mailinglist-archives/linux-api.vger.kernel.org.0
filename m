Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02C3123492
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2019 19:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLQSSI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Dec 2019 13:18:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbfLQSSI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Dec 2019 13:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576606687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6me/j9F+UFJdOSjhQgBCZF5NfyZBjY7IQy05nO+zBqQ=;
        b=bZX4s4mcqr5ENP6uYd6r9lOQpROUKvFpDynlRnvkqVO/6VwiwC0jqHcgqfQ4T+2fJLHlxr
        Y86hVqxy2kPqTyRwiluLb78RS9T4Ng82XUiRkcsvMOsqk9I18a1xRxiNRo0eLLn3rT1Sdy
        y3UjFkr/3MA40bBPoCcwKCtSBRWay7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-50DU1aUYOg6XsGTfYA4RPA-1; Tue, 17 Dec 2019 13:18:02 -0500
X-MC-Unique: 50DU1aUYOg6XsGTfYA4RPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5A0CDB98;
        Tue, 17 Dec 2019 18:18:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9BF60BF1;
        Tue, 17 Dec 2019 18:18:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191217165350.GA10729@nautica>
References: <20191217165350.GA10729@nautica> <87r213aykv.fsf@oldenburg2.str.redhat.com> <20191217152154.GB25518@nautica>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, Quentin Bouget <quentin.bouget@cea.fr>,
        Jeff Layton <jlayton@kernel.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: statx struct's stx_size pointer compatibility with uint64_t/size_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2918.1576606679.1@warthog.procyon.org.uk>
Date:   Tue, 17 Dec 2019 18:17:59 +0000
Message-ID: <2919.1576606679@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> Looking at this from a kernel's point of view, it looks like there
> really was a will to simplify 64-bit ints handling over all arches and
> have them all define 64-bit ints as long long a few years back.

Think printk() too.  Do you use "%lu", "%Lu" or "%llu"?  It's a lot easier if
__u64 is consistently unsigned long long - then it's always "%llu".

The problem with defining it as "unsigned long" on some platforms and
"unsigned long long" on others is that you're guaranteed warnings on one arch
or another.

David

