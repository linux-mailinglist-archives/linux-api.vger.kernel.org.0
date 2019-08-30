Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B395A3C00
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3Q22 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Aug 2019 12:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbfH3Q22 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Aug 2019 12:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80220882EA;
        Fri, 30 Aug 2019 16:28:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB8CA60166;
        Fri, 30 Aug 2019 16:28:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190820001805.241928-4-matthewgarrett@google.com>
References: <20190820001805.241928-4-matthewgarrett@google.com> <20190820001805.241928-1-matthewgarrett@google.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     dhowells@redhat.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V40 03/29] security: Add a static lockdown policy LSM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3439.1567182506.1@warthog.procyon.org.uk>
Date:   Fri, 30 Aug 2019 17:28:26 +0100
Message-ID: <3440.1567182506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 30 Aug 2019 16:28:28 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Matthew Garrett <matthewgarrett@google.com> wrote:

> +static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {

const char *const maybe?

> +static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
> +						 LOCKDOWN_INTEGRITY_MAX,
> +						 LOCKDOWN_CONFIDENTIALITY_MAX};
> +

const?

Isn't this also a 1:1 mapping?

> +static int lock_kernel_down(const char *where, enum lockdown_reason level)

Is the last parameter the reason or the level?  You're mixing the terms.

David
