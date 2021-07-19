Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B93CECFC
	for <lists+linux-api@lfdr.de>; Mon, 19 Jul 2021 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbhGSRjy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jul 2021 13:39:54 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:35849 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355519AbhGSRcd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jul 2021 13:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1626718393; x=1658254393;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VzvZu29zOp7shLhWo6Q+hyIk6zoz9Y0UhxdZuvE/Y24=;
  b=rEjltEZlhcSecXMOT7kJdsAPCYi0TsoeT5wXWEh/Xrsr2sv3hJAsTmzz
   tgh94nXEvf5L95b8OEV6H4X++SFjOeofhJPyzfVJojh3H2rVmP45v7Ai1
   DVnYrYp5wkDq114XR8c14CExwiVxVEfIT7v62op3hktrIKPESyg4VNG8+
   M=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2021 14:13:06 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 14:13:05 -0400
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Peter Oskolkov <posk@google.com>
CC:     <posk@posk.io>, <avagin@google.com>, <bsegall@google.com>,
        <jannh@google.com>, <jnewsome@torproject.org>,
        <joel@joelfernandes.org>, <linux-api@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <pjt@google.com>, <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
References: <20210716184719.269033-5-posk@google.com>
 <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
 <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca>
Date:   Mon, 19 Jul 2021 14:13:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm02.connect.uwaterloo.ca (172.16.137.66) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > Latency/efficiency: on worker wakeup an idle server can be picked from
 > the list and context-switched into synchronously, on the same CPU.
 > Using FDs and select/poll/epoll will add extra layers of abstractions;
 > synchronous context-switches (not yet fully implemented in UMCG) will
 > most likely be impossible. This patchset seems much more efficient and
 > lightweight than whatever can be built on top of FDs.

I can believe that.

Are you planning to support separate scheduling instances within a 
single user
space? That is having multiple sets of server threads and workers can 
only run
within a specific set.

I believe the problem with the idle_servers_ptr as specified is that it 
is not
possible to reclaim used nodes safely. I don't see any indication of which
nodes the kernel can concurrently access and on which some memory 
reclamation
scheme could be based.

What is the benefit of having users maintain themselves a list of idle 
servers
rather than each servers marking themselves as 'out of work' and having the
kernel maintain the list?
