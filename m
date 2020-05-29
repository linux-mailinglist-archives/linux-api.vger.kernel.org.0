Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CAA1E7951
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgE2JYm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 05:24:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgE2JYm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 05:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590744281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BzM0J67x9nJBmGOHRTCJF7StURA0qrq0ZGgLKSvupb4=;
        b=QWaOpvf94DHgxt0fJHkFIcpcJGz7EMuI1X3LHIl8fGF8d6zwtVOiePiPItrSqcPQbN3ZVQ
        cTUiEYLwB0lBjORoSrR4ZYNusvN+uxQCC+FHBq2jg7n7fwr0iCV7XAInOwq4nCtDm0lZzE
        a4NsDmnIp56U6UUuhsqqtQjt13dK3x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-5GcvbPxhP66LlxY34JBtFw-1; Fri, 29 May 2020 05:24:37 -0400
X-MC-Unique: 5GcvbPxhP66LlxY34JBtFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1133107ACF2;
        Fri, 29 May 2020 09:24:35 +0000 (UTC)
Received: from localhost (ovpn-113-216.ams2.redhat.com [10.36.113.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36EAC5C1C3;
        Fri, 29 May 2020 09:24:34 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     keescook@chromium.org, rsesek@google.com, palmer@google.com,
        jannh@google.com, jeffv@google.com,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@google.com>, linux-kernel@vger.kernel.org,
        Matt Denton <mpdenton@google.com>, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user notifier
References: <20200528110858.3265-1-sargun@sargun.me>
        <20200528110858.3265-3-sargun@sargun.me>
Date:   Fri, 29 May 2020 11:24:33 +0200
In-Reply-To: <20200528110858.3265-3-sargun@sargun.me> (Sargun Dhillon's
        message of "Thu, 28 May 2020 04:08:57 -0700")
Message-ID: <87wo4vt7ou.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sargun Dhillon <sargun@sargun.me> writes:

> This adds a seccomp notifier ioctl which allows for the listener to "add"
> file descriptors to a process which originated a seccomp user
> notification. This allows calls like mount, and mknod to be "implemented",
> as the return value, and the arguments are data in memory. On the other
> hand, calls like connect can be "implemented" using pidfd_getfd.
>
> Unfortunately, there are calls which return file descriptors, like
> open, which are vulnerable to TOC-TOU attacks, and require that the
> more privileged supervisor can inspect the argument, and perform the
> syscall on behalf of the process generating the notifiation. This
> allows the file descriptor generated from that open call to be
> returned to the calling process.
>
> In addition, there is funcitonality to allow for replacement of
> specific file descriptors, following dup2-like semantics.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Tycho Andersen <tycho@tycho.ws>
> ---

Thanks, this is a really useful feature.

Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>

