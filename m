Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1897D888C5
	for <lists+linux-api@lfdr.de>; Sat, 10 Aug 2019 08:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfHJGIu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 10 Aug 2019 02:08:50 -0400
Received: from namei.org ([65.99.196.166]:39752 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfHJGIu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 10 Aug 2019 02:08:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7A68gCg025359;
        Sat, 10 Aug 2019 06:08:42 GMT
Date:   Sat, 10 Aug 2019 16:08:42 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V38 00/29] security: Add support for locking down the
 kernel
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1908101608260.25186@namei.org>
References: <20190808000721.124691-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 7 Aug 2019, Matthew Garrett wrote:

> Fixed an unused function parameter in patch 19, otherwise identical to
> V37.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown
and next-testing
  
Please verify and test, as I had to make a few minor fixups for my v5.2   
base.


-- 
James Morris
<jmorris@namei.org>

