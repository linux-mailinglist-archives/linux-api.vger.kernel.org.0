Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA081900D0
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 23:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWWBI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 18:01:08 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:28952 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWWBI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 18:01:08 -0400
IronPort-SDR: UbZiZEzjDpL9B+hpsdp1UWEyBg8iMEQP6t7DBoT6pYpIkALAOcpRmL3iEOEhe1FG8IXweQmw5b
 imsU3t9qtlStb0m18qdCYZ++GoGht+RjDZnEPWyxIdFsie9ZI5gkE5JKeiQSy6IEYXW2UzCfdd
 i0Xe8EzxxLY6qMaMhUXZtPQFRXnU8rygOpHy6RS6MROvnC8pmE3D4VnVRybIsNxc4sPaAOoVuG
 QIobntBjlICue3igQdTa+JWnpPFPd+R4sVdpubOJxKOdr2Geh9zTHBT317ywKTnwZMAah6STNH
 NnE=
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="47063343"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 23 Mar 2020 14:01:08 -0800
IronPort-SDR: Fzhw1yRT7C2W0xhbIVsOr6jpMwWZ+k+MPOS1UzYeVKmCPpMa2QQ8bpDvg7G5EvbMktE4zE2VpW
 shL4GWT+hYGPuhwhFcbN9B5UpjlMj/l2hjXJFTrFhtCo21k/4eUJWxfD/3C6+JNkt2PPE+vr3p
 stcj7/0pDOdwqDc01aOofY0UCjPp4vtgANdPQVx+F5+lDT5rnBjKNQkj+GKk/YO5q5tC2Y8sX9
 fCuxdsqy2kFL5wq6OiLvg556fsOMNcCOTM9s+Qm5Ajz1mZoXL7dR8qJp0fgsaadUI3UrdNxObU
 9q8=
Date:   Mon, 23 Mar 2020 22:01:00 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Carlos O'Donell <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        <libc-alpha@sourceware.org>, <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v16)
In-Reply-To: <20200323131607.15185-5-mathieu.desnoyers@efficios.com>
Message-ID: <alpine.DEB.2.21.2003232159310.13609@digraph.polyomino.org.uk>
References: <20200323131607.15185-1-mathieu.desnoyers@efficios.com> <20200323131607.15185-5-mathieu.desnoyers@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Note that we no longer use manually-written ChangeLog-format logs.

The NEWS entry needs to move under the 2.32 header.

The new symbol needs to move to GLIBC_2.32 symbol version.

-- 
Joseph S. Myers
joseph@codesourcery.com
