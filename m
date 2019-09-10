Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE177AEA5E
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfIJMaF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 08:30:05 -0400
Received: from namei.org ([65.99.196.166]:43636 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbfIJMaF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Sep 2019 08:30:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x8ACTxV6027709;
        Tue, 10 Sep 2019 12:30:00 GMT
Date:   Tue, 10 Sep 2019 05:29:59 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/2] Minor lockdown fixups
In-Reply-To: <20190910100318.204420-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1909100529300.27252@namei.org>
References: <20190910100318.204420-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 10 Sep 2019, Matthew Garrett wrote:

> Constify some arrays and fix an #ifdef that I typoed.
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown
and next-testing


-- 
James Morris
<jmorris@namei.org>

