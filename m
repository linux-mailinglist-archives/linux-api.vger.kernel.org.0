Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1387847344E
	for <lists+linux-api@lfdr.de>; Mon, 13 Dec 2021 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhLMSsI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Dec 2021 13:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239107AbhLMSsH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Dec 2021 13:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639421286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IZA4xjEIh7Zb3XLnVY+jMJuGdAsBHkK6kvdfHR2CrEA=;
        b=LVsRtilH2JXBbEfu/RWF1AAONE1+kJyN7NalKv9a9pvPuuJYUJC36bU9S5oXDBUZKgkwmV
        Ok2d8NnpvUQald0tK9wRUFCXqbBQalcAnrT/bNVheeR3Y4fpigb9uasASC2ZtlWHDQN9u/
        wVsNqvtVQqQEUytOK73lGrn55/RRQFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-WEf4s8ghPxarDYjyyENOKQ-1; Mon, 13 Dec 2021 13:48:03 -0500
X-MC-Unique: WEf4s8ghPxarDYjyyENOKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A58B81CCBE;
        Mon, 13 Dec 2021 18:48:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4CDC45D87;
        Mon, 13 Dec 2021 18:48:00 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-api@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Jann Horn <jannh@google.com>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: rseq + membarrier programming model
Date:   Mon, 13 Dec 2021 19:47:57 +0100
Message-ID: <87tufctk82.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I've been studying Jann Horn's biased locking example:

  Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
  <https://lore.kernel.org/linux-api/CAG48ez02UDn_yeLuLF4c=kX0=h2Qq8Fdb0cer1yN8atbXSNjkQ@mail.gmail.com/>

It uses MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ as part of the biased lock
revocation.

How does the this code know that the process has called
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ?  Could it fall back to
MEMBARRIER_CMD_GLOBAL instead?  Why is it that MEMBARRIER_CMD_GLOBAL
does not require registration (the broader/more expensive barrier), but
the more restricted versions do?

Or put differently, why wouldn't we request
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ unconditionally at
process start in glibc, once we start biased locking in a few places?

Thanks,
Florian

