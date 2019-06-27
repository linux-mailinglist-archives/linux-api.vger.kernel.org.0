Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BE58993
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF0SOx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 14:14:53 -0400
Received: from namei.org ([65.99.196.166]:49192 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF0SOx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 27 Jun 2019 14:14:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5RIEUPY018953;
        Thu, 27 Jun 2019 18:14:30 GMT
Date:   Fri, 28 Jun 2019 04:14:30 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
In-Reply-To: <CACdnJusJeCYPKVFHiu6yn+mfqQe5k0RqZhbCUZEkxtXx_shMmw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1906280411370.18880@namei.org>
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-10-matthewgarrett@google.com> <alpine.LRH.2.21.1906271423070.16512@namei.org> <CACdnJusJeCYPKVFHiu6yn+mfqQe5k0RqZhbCUZEkxtXx_shMmw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 27 Jun 2019, Matthew Garrett wrote:

> By that metric, on a secure boot system how do we determine that code
> running in the firmware environment wasn't compromised before it
> launched the initial signed kernel?

Remote attestation tied to a hardware root of trust, before allowing 
access to any further resources.


-- 
James Morris
<jmorris@namei.org>

