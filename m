Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBC8A65D
	for <lists+linux-api@lfdr.de>; Mon, 12 Aug 2019 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfHLSgK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Aug 2019 14:36:10 -0400
Received: from namei.org ([65.99.196.166]:40086 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLSgK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Aug 2019 14:36:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7CHdH4p014540;
        Mon, 12 Aug 2019 17:39:17 GMT
Date:   Tue, 13 Aug 2019 03:39:17 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V38 00/29] security: Add support for locking down the
 kernel
In-Reply-To: <CACdnJusx3N_ZoH4=+tqt85K9J5wmUnC-+bTtG_5qSD_TYu74+A@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1908130339130.14197@namei.org>
References: <20190808000721.124691-1-matthewgarrett@google.com> <alpine.LRH.2.21.1908101608260.25186@namei.org> <CACdnJusx3N_ZoH4=+tqt85K9J5wmUnC-+bTtG_5qSD_TYu74+A@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 12 Aug 2019, Matthew Garrett wrote:

> On Fri, Aug 9, 2019 at 11:08 PM James Morris <jmorris@namei.org> wrote:
> > Please verify and test, as I had to make a few minor fixups for my v5.2
> > base.
> 
> Thanks James - there's a few small fixups required, would you like
> those as separate patches or should I just send you a fixed copy of
> the original patchset?

Given there are a few, an updated copy of the patchset will be best.

-- 
James Morris
<jmorris@namei.org>

