Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278CD57ADF
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfF0E7f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 00:59:35 -0400
Received: from namei.org ([65.99.196.166]:48942 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0E7f (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 27 Jun 2019 00:59:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5R4x9Cl020018;
        Thu, 27 Jun 2019 04:59:09 GMT
Date:   Thu, 27 Jun 2019 14:59:09 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
In-Reply-To: <20190622000358.19895-10-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1906271423070.16512@namei.org>
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-10-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 21 Jun 2019, Matthew Garrett wrote:

> From: Jiri Bohac <jbohac@suse.cz>
> 
> When KEXEC_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down.

This is not a criticism of the patch but a related issue which I haven't 
seen discussed (apologies if it has).

If signed code is loaded into ring 0, verified by the kernel, then 
executed, you still lose your secure/trusted/verified boot state. If the 
currently running kernel has been runtime-compromised, any signature 
verification performed by the kernel cannot be trusted.

This problem is out of scope for the lockdown threat model (which 
naturally cannot include a compromised kernel), but folk should be aware 
that signature-verified kexec does not provide equivalent assurance to a 
full reboot on a secure-boot system.

Potential mitigations here include runtime integrity verification of the
kernel via a separate security monitor (hypervisor, SMM, TEE etc.) or some
kind of platform support for kexec verification.


-- 
James Morris
<jmorris@namei.org>

