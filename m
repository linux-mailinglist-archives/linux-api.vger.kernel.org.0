Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2217A3187AC
	for <lists+linux-api@lfdr.de>; Thu, 11 Feb 2021 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBKKD0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Feb 2021 05:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhBKJ7b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Feb 2021 04:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613037485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=RcvQZfQlzkXbDd+sedEX6d4tNtyfERJhF6wUYmJztMg=;
        b=eDxt/JXAuk0au+HqC55V9ff8vVb7a0Pnx1yxAXrlgMxdQ5uFtXx3c+nYqYL4yKdS4NOY5i
        eMUIdjp6J9h+rwk4T9b742ezlX6+LIKZnqO7HXv0L4vXnK6CGS53njMIoUyu+v7BUksRqZ
        k7kv/cOpl83kZKkLxT1wjmmYGF1ylWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-gDE4tcORO2yDBwN0hS3Apg-1; Thu, 11 Feb 2021 04:58:03 -0500
X-MC-Unique: gDE4tcORO2yDBwN0hS3Apg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F9085B660;
        Thu, 11 Feb 2021 09:58:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-131.ams2.redhat.com [10.36.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4745D9E8;
        Thu, 11 Feb 2021 09:58:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Are vDSO addresses special?
Date:   Thu, 11 Feb 2021 10:58:20 +0100
Message-ID: <87zh0bq62r.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In glibc, we have some code that copies the DT_SONAME string of the
kernel vDSO into the heap, commented this way:

             /* Work around a kernel problem.  The kernel cannot handle
                addresses in the vsyscall DSO pages in writev() calls.  */

Is this really a problem anymore?  vDSO addresses are ordinary userspace
addresses, I think.  (The vsyscall stuff is very different, of course,
and maybe the vDSO started out the same way.)

We only care about Linux 3.2 or later in glibc.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

