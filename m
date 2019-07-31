Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588EA7B7BE
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2019 03:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfGaBsJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Jul 2019 21:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaBsI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 30 Jul 2019 21:48:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9C02067D;
        Wed, 31 Jul 2019 01:48:07 +0000 (UTC)
Date:   Tue, 30 Jul 2019 21:48:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] tracefs: Restrict tracefs when the kernel is locked
 down
Message-ID: <20190730214803.6d06da65@oasis.local.home>
In-Reply-To: <20190730184734.202386-1-matthewgarrett@google.com>
References: <20190724222354.7cbd6c6e@oasis.local.home>
        <20190730184734.202386-1-matthewgarrett@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 30 Jul 2019 11:47:34 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> Tracefs may release more information about the kernel than desirable, so
> restrict it when the kernel is locked down in confidentiality mode by
> preventing open().
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
