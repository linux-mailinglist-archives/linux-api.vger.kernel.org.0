Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF393C94CE
	for <lists+linux-api@lfdr.de>; Thu, 15 Jul 2021 02:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhGOASf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 20:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236618AbhGOASf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Jul 2021 20:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CE62613CA;
        Thu, 15 Jul 2021 00:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626308141;
        bh=Fqy8q1GvFf2rB7W7o9rtwviSp4fk5KSMK7Dm5WpYiWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g8YCHlp5dl396g1XhSIrqvKv6404oJvcet/t5nsbAMYxTPIwDKWhsOLAw7q0im44e
         5t+wMUNKUUq2KB8Rcf/qvw0WNlH5+NTBtRQUW77eTUXq3bZ1+4KLnGxiBRtJ5m79vy
         zK1XaU5NL8xb/tp1CaEO/M8HUjtFxKiXxQ7gt+ss=
Date:   Wed, 14 Jul 2021 17:15:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v6 0/6] Introduce multi-preference mempolicy
Message-Id: <20210714171540.7cb9e221d683b531928b71f5@linux-foundation.org>
In-Reply-To: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 12 Jul 2021 16:09:28 +0800 Feng Tang <feng.tang@intel.com> wrote:

> This patch series introduces the concept of the MPOL_PREFERRED_MANY mempolicy.
> This mempolicy mode can be used with either the set_mempolicy(2) or mbind(2)
> interfaces. Like the MPOL_PREFERRED interface, it allows an application to set a
> preference for nodes which will fulfil memory allocation requests. Unlike the
> MPOL_PREFERRED mode, it takes a set of nodes. Like the MPOL_BIND interface, it
> works over a set of nodes. Unlike MPOL_BIND, it will not cause a SIGSEGV or
> invoke the OOM killer if those preferred nodes are not available.

Do we have any real-world testing which demonstrates the benefits of
all of this?
