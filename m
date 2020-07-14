Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631F121FEFC
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 22:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGNUzY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 16:55:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728002AbgGNUzW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 16:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594760121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IG4HUAqsDTrwc0sdFRqFLUeiV5cP2XX7c9955RD/JLA=;
        b=abWIicW1tXVt8PE1C5dATj95gkBSu/9q577V0oylr+pSa5euzEv4hWboGjdGtGf28SsBL6
        S1Z7nIsty/5m46grHvbEdUh6PxWE7MxV5MAbabYpKNwgFagz/e+sSK3LjLOezm1ZJsVSKn
        oreqdWDn0xL/X3szoKm/P6dm9hp4uyc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-BhscG5ZmMCeTneoAJFDWOA-1; Tue, 14 Jul 2020 16:55:15 -0400
X-MC-Unique: BhscG5ZmMCeTneoAJFDWOA-1
Received: by mail-qv1-f72.google.com with SMTP id x37so4632863qvf.4
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 13:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IG4HUAqsDTrwc0sdFRqFLUeiV5cP2XX7c9955RD/JLA=;
        b=NPg1vm9h0UWAYQvLFD//VKh3Nq2TmbKQm1xeexI+L1Llz0d9r+0LHuOisinyfcUWdq
         ak7n2y2TebXH2k9+YsryzpoIAKN19/DWpfz8MkzCq4puVkHb9BzfM9ZaPQqpY3cJq7oj
         vpq5Ag0mJj/+vZxc6hCE4dE2TC0fZWTvHdYT4ifH400dln3e+G66l8nmrNs14ekBqV2C
         hqZRRhFESHQifmJmW8Fz+v0TQH+Kx7TXsbigxgnm5Norhv5Kt4SzxkEYkhObxgB8tURk
         vfu4AQDA1MKxqaezzBC7SulSK1h7H2EG2cpvJBSvCwsApFPIB4nsjuyKIw6Slbb6js/g
         AYnQ==
X-Gm-Message-State: AOAM533o9nN3MJs4ZzLAkUK0KeEZfub28kK9BS9ANl+hgdmiEKf58asU
        JCVd/BRsW1QUg+kz6hI9xNCywVBdggCUFHdP0skThZi5QWwYEMxJIjgk9PyYvaTvYiXSjKZ3Xaz
        ArAFgK/2hYGMOCi/QvLFe
X-Received: by 2002:ac8:1667:: with SMTP id x36mr6817826qtk.344.1594760114506;
        Tue, 14 Jul 2020 13:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSc9JqI/7mPb4eGFhz4PiDFiEHI9lotYrjvFjoxySGjr6nl4C6ZtZQY6a3Ef23EDowBCDgsA==
X-Received: by 2002:ac8:1667:: with SMTP id x36mr6817798qtk.344.1594760114128;
        Tue, 14 Jul 2020 13:55:14 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id k197sm24103418qke.133.2020.07.14.13.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 13:55:13 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com>
Date:   Tue, 14 Jul 2020 16:55:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/13/20 11:03 PM, Mathieu Desnoyers wrote:
> Recent discussion led to a solution for extending struct rseq. This is
> an implementation of the proposed solution.
> 
> Now is a good time to agree on this scheme before the release of glibc
> 2.32, just in case there are small details to fix on the user-space
> side in order to allow extending struct rseq.

Adding extensibility to the rseq registration process would be great,
but we are out of time for the glibc 2.32 release.

Should we revert rseq for glibc 2.32 and spend quality time discussing
the implications of an extensible design, something that Google already
says they are doing?

We can, with a clear head, and an agreed upon extension mechanism
include rseq in glibc 2.33 (release scheduled for Feburary 1st 2021).
We release time boxed every 6 months, no deviation, so you know when
your next merge window will be.

We have already done the hard work of fixing the nesting signal
handler issues, and glibc integration. If we revert today that will 
also give time for Firefox and Chrome to adjust their sandboxes.

Do you wish to go forward with rseq as we have it in glibc 2.32,
or do you wish to revert rseq from glibc 2.32, discuss the extension
mechanism, and put it back into glibc 2.33 with adjustments?

-- 
Cheers,
Carlos.

