Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E31A3C0D
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfH3QbQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Aug 2019 12:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbfH3QbQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Aug 2019 12:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C3F1189DAD6;
        Fri, 30 Aug 2019 16:31:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9608E10021B2;
        Fri, 30 Aug 2019 16:31:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190820001805.241928-5-matthewgarrett@google.com>
References: <20190820001805.241928-5-matthewgarrett@google.com> <20190820001805.241928-1-matthewgarrett@google.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     dhowells@redhat.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH V40 04/29] lockdown: Enforce module signatures if the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3637.1567182673.1@warthog.procyon.org.uk>
Date:   Fri, 30 Aug 2019 17:31:13 +0100
Message-ID: <3638.1567182673@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 30 Aug 2019 16:31:16 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Matthew Garrett <matthewgarrett@google.com> wrote:

>  enum lockdown_reason {
>  	LOCKDOWN_NONE,
> +	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };

Aren't you mixing disjoint sets?

> +	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",

Wouldn't it be better to pass this string as a parameter to
security_locked_down()?

David
