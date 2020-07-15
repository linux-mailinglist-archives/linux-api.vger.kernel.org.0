Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC1222109B
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGOPNd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 11:13:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbgGOPNc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 11:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594826011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SLr4XU8Zt9nR4MhV7pccKhkMvz8sYtWmhpN/hWtv1I8=;
        b=HjIdtSu3TbqrW8Y7vX/kDOuW3LpJmfcGE/r+ZrvTwNW2f4tfVrQbYIH1n5ac3+0aO0FvD/
        u3aZyyKX6VkKURVX/9+4//rb+xa4QwShSISc6dRyAzWAY7DccWBsOgZtkbEN7QfP2c3LkI
        9hVnaGdaU809nEWgkxLZRpa6ukb/yI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-mZSMVSBVMIe8Af8C462YOA-1; Wed, 15 Jul 2020 11:13:08 -0400
X-MC-Unique: mZSMVSBVMIe8Af8C462YOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C43A800597;
        Wed, 15 Jul 2020 15:13:06 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-228.ams2.redhat.com [10.36.112.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA32379D06;
        Wed, 15 Jul 2020 15:13:00 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
        <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com>
Date:   Wed, 15 Jul 2020 17:12:59 +0200
In-Reply-To: <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com> (Carlos
        O'Donell's message of "Tue, 14 Jul 2020 16:55:11 -0400")
Message-ID: <87a700zu9w.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Carlos O'Donell:

> On 7/13/20 11:03 PM, Mathieu Desnoyers wrote:
>> Recent discussion led to a solution for extending struct rseq. This is
>> an implementation of the proposed solution.
>> 
>> Now is a good time to agree on this scheme before the release of glibc
>> 2.32, just in case there are small details to fix on the user-space
>> side in order to allow extending struct rseq.
>
> Adding extensibility to the rseq registration process would be great,
> but we are out of time for the glibc 2.32 release.
>
> Should we revert rseq for glibc 2.32 and spend quality time discussing
> the implications of an extensible design, something that Google already
> says they are doing?
>
> We can, with a clear head, and an agreed upon extension mechanism
> include rseq in glibc 2.33 (release scheduled for Feburary 1st 2021).
> We release time boxed every 6 months, no deviation, so you know when
> your next merge window will be.
>
> We have already done the hard work of fixing the nesting signal
> handler issues, and glibc integration. If we revert today that will 
> also give time for Firefox and Chrome to adjust their sandboxes.
>
> Do you wish to go forward with rseq as we have it in glibc 2.32,
> or do you wish to revert rseq from glibc 2.32, discuss the extension
> mechanism, and put it back into glibc 2.33 with adjustments?

I posted the glibc revert:

  <https://sourceware.org/pipermail/libc-alpha/2020-July/116368.html>

I do not think we have any other choice at this point.

Thanks,
Florian

