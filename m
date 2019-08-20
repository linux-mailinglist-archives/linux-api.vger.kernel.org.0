Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DE95796
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfHTGqA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 02:46:00 -0400
Received: from namei.org ([65.99.196.166]:40196 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbfHTGqA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Aug 2019 02:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7K6jqVD012448;
        Tue, 20 Aug 2019 06:45:52 GMT
Date:   Mon, 19 Aug 2019 23:45:52 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V40 00/29] Add kernel lockdown functionality
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1908192345270.12391@namei.org>
References: <20190820001805.241928-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 19 Aug 2019, Matthew Garrett wrote:

> After chatting with James in person, I'm resending the full set with the
> fixes merged in in order to avoid any bisect issues. There should be no
> functional changes other than avoiding build failures with some configs,
> and fixing the oops in tracefs.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown
and next-testing

Thanks!

-- 
James Morris
<jmorris@namei.org>

