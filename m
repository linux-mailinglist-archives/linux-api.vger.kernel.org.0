Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D95191994
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 19:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgCXS7K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 14:59:10 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:49951 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgCXS7K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 14:59:10 -0400
IronPort-SDR: mNtaeIzLsBUvVtDLZkq5OaNJgLKmdTLJdpF/6e93UkiUnaQSwDr6KR5Gh3NHfzPcklNeydxoJ0
 1GwyKfp1DJG3cayxf7PSbwyiHmxI/mQHuNX9joppbKwxWnU/YfodYRg6XPxUx/lHSU9TkvaLJT
 emXSBv/EI0AxWSQxrn9HHq4b5cvUuJ1hTht8vmJTnsqwNxrUG3/0vCMF8kG3P9vmdwumiHf2op
 ASk8+2jOM7k4QDIOO6SgKqQiEPNptHWfoQ0kksgDi+lzAOHB9/BTRy0TuSK83xsd26Xw8VzkzI
 yZQ=
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; 
   d="scan'208";a="47057405"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 24 Mar 2020 10:59:04 -0800
IronPort-SDR: POOcMK/ErwXKMmrnS2XhLpVziLt/gYxOh1bEauXnbCkDxAj36k7LTHb0wv9H7EmEm0A4yNtVSY
 jFp1A8PyvEGxK92OX3dxQakCF2YFByItEcrTyN/sCemsFcZO9IF2/IpgVSJP8dAJA193ccC3PS
 WvAXDQVA275FrokKU19SeAGRFCVx41bsObOj9KJ8cuVSrS5H1SNvubDrAtHXWxwapuQpi/5NmG
 Jjwrk+bxdmnbNmrmrrtTdb4mNjTZtJll2omYY7D2ZkD+MgGc2BCafReWacCD3zIgLVaT8sUs3S
 gEU=
Date:   Tue, 24 Mar 2020 18:58:58 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v16)
In-Reply-To: <1873939476.8349.1585055299958.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.2003241857350.8310@digraph.polyomino.org.uk>
References: <20200323131607.15185-1-mathieu.desnoyers@efficios.com> <20200323131607.15185-5-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.2003232159310.13609@digraph.polyomino.org.uk> <1873939476.8349.1585055299958.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 24 Mar 2020, Mathieu Desnoyers via Libc-alpha wrote:

> ----- On Mar 23, 2020, at 6:01 PM, Joseph Myers joseph@codesourcery.com wrote:
> 
> > Note that we no longer use manually-written ChangeLog-format logs.
> 
> Do you mean the part at the end of the commit message ?

I mean the

	* filename: Changes to this file.
	* other/file: Likewise.

part.

-- 
Joseph S. Myers
joseph@codesourcery.com
